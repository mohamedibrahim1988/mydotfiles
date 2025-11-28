#!/bin/sh
set -eu

TMUX_BIN="$(command -v tmux || {
    echo 'tmux not found'
    exit 1
})"
FZY_BIN="$(command -v fzy || {
    echo 'fzy not found'
    exit 1
})"

FZY_OPTS='-l 30 -p Sessions:'

# List existing sessions (just names)
sessions="$("$TMUX_BIN" list-sessions -F '#{session_name}' 2>/dev/null || true)"
CREATE="Create new session…"
KILL="Kill session…"
RENAME="Rename session…"
CLONE="Clone session…"
menu="$CREATE\n$KILL\n$RENAME\n$CLONE\n$sessions"

choice="$(printf '%b' "$menu" | eval "$FZY_BIN $FZY_OPTS" || true)"
[ -n "$choice" ] || exit 0

# Handle special actions first
case "$choice" in
    "$KILL")
        kill_target="$(printf '%b' "$sessions" | $FZY_BIN -p 'Kill which session?' || true)"
        [ -n "$kill_target" ] || exit 0

        printf "Kill session '$kill_target'? (y/N): "
        read -r confirm
        case "$confirm" in
            [yY]|[yY][eE][sS])
                "$TMUX_BIN" kill-session -t "$kill_target"
                ;;
            *)
                echo "Cancelled"
                ;;
        esac
        exit 0
        ;;
    "$RENAME")
        rename_src="$(printf '%b' "$sessions" | eval "$FZY_BIN -p 'Rename which session?'" || true)"
        [ -n "$rename_src" ] || exit 0
        
        printf "New name for '$rename_src': "
        read -r rename_dst
        [ -n "$rename_dst" ] || exit 0

        "$TMUX_BIN" rename-session -t "$rename_src" "$rename_dst"
        exit 0
        ;;
    "$CLONE")
        clone_src="$(printf '%b' "$sessions" | eval "$FZY_BIN -p 'Clone which session?'" || true)"
        [ -n "$clone_src" ] || exit 0
        
        printf "New session name: "
        read -r clone_dst
        [ -n "$clone_dst" ] || exit 0

        "$TMUX_BIN" new-session -d -t "$clone_src" -s "$clone_dst"
        
        # If inside tmux, switch to cloned session
        if [ -n "${TMUX-}" ]; then
            exec "$TMUX_BIN" switch-client -t "$clone_dst"
        else
            # Outside tmux: attach to cloned session directly
            exec "$TMUX_BIN" attach -t "$clone_dst"
        fi
        exit 0
        ;;
esac

# Handle session creation/selection
if [ "$choice" = "$CREATE" ]; then
    printf "New session name: "
    read -r new_name
    [ -n "$new_name" ] || exit 0
    session="$new_name"
    create=1
else
    session="$choice"
    create=0
fi

# Inside tmux: create (detached) if needed, then switch
if [ -n "${TMUX-}" ]; then
    if [ "$create" -eq 1 ] && ! "$TMUX_BIN" has-session -t "$session" 2>/dev/null; then
        "$TMUX_BIN" new-session -ds "$session"
    fi
    exec "$TMUX_BIN" switch-client -t "$session"
fi

# Outside tmux: attach directly in current terminal
if [ "$create" -eq 1 ]; then
    # create and attach
    exec "$TMUX_BIN" new-session -s "$session"
else
    # attach existing
    exec "$TMUX_BIN" attach -t "$session"
fi