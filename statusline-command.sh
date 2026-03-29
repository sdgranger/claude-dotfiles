#!/bin/sh
input=$(cat)
cwd=$(echo "$input" | jq -r '.cwd // .workspace.current_dir // empty')
model=$(echo "$input" | jq -r '.model.display_name // empty')
used=$(echo "$input" | jq -r '.context_window.used_percentage // empty')

parts=""

[ -n "$cwd" ] && parts="$cwd"

[ -n "$model" ] && {
  [ -n "$parts" ] && parts="$parts | "
  parts="${parts}Model: $model"
}

if [ -n "$used" ]; then
  used_int=$(printf "%.0f" "$used")
  [ -n "$parts" ] && parts="$parts | "
  parts="${parts}Context: ${used_int}% used"
fi

echo "$parts"
