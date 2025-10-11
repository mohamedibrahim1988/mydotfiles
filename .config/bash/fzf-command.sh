#!/bin/bash

eval "$(fzf --bash)"
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow'
export FZF_DEFAULT_OPTS="-i --height=50%\
    --margin=5%,2%,2%,5% \
    --layout=reverse-list \
    --border=bold \
    --info=inline \
    --prompt='$>' \
    --pointer='➔' \
    --marker='' \
    --header='CTRL-c or ESC to quit' \
    --color='dark,fg:magenta'"
source "$XDG_CONFIG_HOME/fzf-marks/fzf-marks.plugin.bash"
export FZF_MARKS_COMMAND="fzf --preview-window=hidden --height 30% --reverse -n 1 -d ' : '"
source "$XDG_CONFIG_HOME/bash/alacritty.bash"
