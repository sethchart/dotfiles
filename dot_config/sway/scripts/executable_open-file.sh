#!/bin/sh
# Pick a file under $HOME with fuzzel and open it with its default app.
cd "$HOME" || exit 1
file=$(fd --type f | fuzzel --dmenu --no-icons --prompt 'open > ' --width 90 --lines 20) || exit 0
[ -n "$file" ] && exec xdg-open "$HOME/$file"
