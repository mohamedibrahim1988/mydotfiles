#!/bin/bash

tmux new -s vim -d
tmux send-keys -t vim 'vim' C-m
tmux attach -t vim
