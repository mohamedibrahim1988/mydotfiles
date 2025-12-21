#!/bin/bash
set -eu

terminal="st"
dmenu_flags="-i -l 30 -p 'Projects:'"

# Pick directory inside ~/.config
configs="$(
    find "$HOME/.config" -mindepth 1 -maxdepth 1 -type d -printf '%f\n' 2>/dev/null |
        sort
)"
[ -n "$configs" ] || exit 0

chosen="$(printf '%s\n' "$configs" | dmenu $dmenu_flags)"
[ -n "$chosen" ] || exit 0

dir="$HOME/.config/$chosen"

# ---- NEW: pick a file inside the chosen directory ----
file="$(
    find "$dir" -type f -printf '%P\n' 2>/dev/null |
        sort |
        dmenu -i -l 30 -p "File:"
)"
[ -n "$file" ] || exit 0

full_path="$dir/$file"
# --------------------------------------------------------

# Kill old terminal
pkill -x "$terminal" 2>/dev/null || true
sleep 0.1

# Open terminal, attach/create tmux session AND open file in nvim
exec "$terminal" -e tmux new-session -As "$chosen" -c "$dir" "nvim" "$full_path"
