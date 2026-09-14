#!/bin/bash
# Claude Code status line: show current working directory (basename)
input=$(cat)
cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd // empty')
[ -z "$cwd" ] && cwd="$PWD"
printf "\033[2m%s\033[0m" "$(basename "$cwd")"
