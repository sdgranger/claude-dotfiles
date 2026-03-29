#!/bin/sh
input=$(cat)

# Extract JSON values without jq using grep+sed
get_val() {
  echo "$input" | grep -o "\"$1\"[[:space:]]*:[[:space:]]*\"[^\"]*\"" | sed 's/.*:[[:space:]]*"//;s/"$//' | head -1
}
get_num() {
  echo "$input" | grep -o "\"$1\"[[:space:]]*:[[:space:]]*[0-9.]*" | sed 's/.*:[[:space:]]*//' | head -1
}

cwd=$(get_val "cwd")
[ -z "$cwd" ] && cwd=$(get_val "current_dir")
model=$(get_val "display_name")
used=$(get_num "used_percentage")

parts=""
# Shorten home prefix to ~/
case "$cwd" in "$HOME"*) cwd="~${cwd#$HOME}" ;; esac
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
