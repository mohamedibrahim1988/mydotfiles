#!/bin/sh

result="$(
  ag --nocolor --nogroup "$@" | fzy -i
)"

[ -z "$result" ] && exit

file=$(printf "%s" "$result" | cut -d: -f1)
line=$(printf "%s" "$result" | cut -d: -f2)

nvim +"$line" "$file"

