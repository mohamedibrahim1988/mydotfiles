#!/bin/sh
set -eu

TMUX_BIN="$(command -v tmux || {
    echo 'tmux not found'
    exit 1
})"
DMENU_BIN="$(command -v dmenu || {
    echo 'dmenu not found'
    exit 1
})"

DMENU_OPTS='-i -l 30 -fn JetBrainsMono\ Nerd\ Font:size=16 -p Sessions:'

# List existing sessions (just names)
sessions="$("$TMUX_BIN" list-sessions -F '#{session_name}' 2>/dev/null || true)"
CREATE="Create new session…"
KILL="Kill session…"
RENAME="Rename session…"
CLONE="Clone session…"
menu="$CREATE\n$KILL\n$RENAME\n$CLONE\n \n$sessions"

choice="$(printf '%b' "$menu" | eval "$DMENU_BIN $DMENU_OPTS" || true)"
[ -n "$choice" ] || exit 0

# Handle special actions first
case "$choice" in
"$KILL")
    kill_target="$(printf '%b' "$sessions" | $DMENU_BIN -p 'Kill which session?' -i || true)"
    [ -n "$kill_target" ] || exit 0

    confirm="$(printf 'No\nYes' | $DMENU_BIN -p "Kill session '$kill_target' ?" -i || true)"
    [ "$confirm" = "Yes" ] || exit 0

    "$TMUX_BIN" kill-session -t "$kill_target"
    exit 0
    ;;
"$RENAME")
    rename_src="$(printf '%b' "$sessions" | eval "$DMENU_BIN -p 'Rename which session?'" || true)"
    [ -n "$rename_src" ] || exit 0

    rename_dst="$(printf '' | eval "$DMENU_BIN -p 'New name:'" || true)"
    [ -n "$rename_dst" ] || exit 0

    "$TMUX_BIN" rename-session -t "$rename_src" "$rename_dst"
    exit 0
    ;;
"$CLONE")
    clone_src="$(printf '%b' "$sessions" | eval "$DMENU_BIN -p 'Clone which session?'" || true)"
    [ -n "$clone_src" ] || exit 0

    clone_dst="$(printf '' | eval "$DMENU_BIN -p 'New session name:'" || true)"
    [ -n "$clone_dst" ] || exit 0

    "$TMUX_BIN" new-session -d -t "$clone_src" -s "$clone_dst"

    # If inside tmux, switch to cloned session
    if [ -n "${TMUX-}" ]; then
        exec "$TMUX_BIN" switch-client -t "$clone_dst"
    else
        # Outside tmux: attach to cloned session
        pkill -x alacritty 2>/dev/null || true
        sleep 0.1
        exec alacritty -e "$TMUX_BIN" attach -t "$clone_dst"
    fi
    exit 0
    ;;
esac

# Handle session creation/selection
if [ "$choice" = "$CREATE" ]; then
    new_name="$(printf '' | eval "$DMENU_BIN -fn JetBrainsMono\\ Nerd\\ Font:size=16 -p 'New session name:'" || true)"
    [ -n "$new_name" ] || exit 0
    session="$new_name"
    create=1
else
    session="$choice"
    create=0
fi

# Inside tmux: create (detached) if needed, then switch (NO exec on create)
if [ -n "${TMUX-}" ]; then
    if [ "$create" -eq 1 ] && ! "$TMUX_BIN" has-session -t "$session" 2>/dev/null; then
        "$TMUX_BIN" new-session -ds "$session"
    fi
    exec "$TMUX_BIN" switch-client -t "$session"
fi

# Outside tmux: one-terminal behavior
pkill -x alacritty 2>/dev/null || true
sleep 0.1
#
if [ "$create" -eq 1 ]; then
    # create and attach
    exec alacritty -e "$TMUX_BIN" new-session -s "$session"
else
    # attach existing
    exec alacritty -e "$TMUX_BIN" attach -t "$session"
fi
