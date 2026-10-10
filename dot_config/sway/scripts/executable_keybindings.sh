#!/bin/sh
# Show sway keybindings in a searchable fuzzel list.
awk '
    # Collect "set $name value" variables so bindings read naturally
    $1 == "set" && $2 ~ /^\$/ { v = $0; sub(/^[ \t]*set[ \t]+[^ \t]+[ \t]+/, "", v); vars[$2] = v; next }
    # Track "mode" blocks so their bindings are labelled
    $1 == "mode" && $NF == "{" { mode = $2; gsub(/"/, "", mode); next }
    mode != "" && $1 == "}" { mode = ""; next }
    $1 == "bindsym" {
        line = $0
        sub(/^[ \t]*bindsym[ \t]+/, "", line)
        while (line ~ /^--[a-z-]+[ \t]+/) sub(/^--[a-z-]+[ \t]+/, "", line)
        key = line; sub(/[ \t].*/, "", key)
        cmd = line; sub(/^[^ \t]+[ \t]+/, "", cmd)
        sub(/^exec[ \t]+/, "", cmd)
        if (cmd ~ /^swaynag/) cmd = "exit sway (asks first)"
        for (name in vars) { gsub("\\" name, vars[name], key); gsub("\\" name, vars[name], cmd) }
        sub(/Mod4/, "Super", key); sub(/Mod1/, "Alt", key)
        if (mode != "") cmd = cmd "  (" mode " mode)"
        printf "%-26s %s\n", key, cmd
    }
' ~/.config/sway/config /etc/sway/config.d/* 2>/dev/null |
    fuzzel --dmenu --no-icons --prompt 'keys > ' --width 90 --lines 20 >/dev/null
