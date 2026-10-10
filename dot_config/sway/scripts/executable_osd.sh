#!/bin/sh
# Change volume or brightness and show the new level in wob.
# Usage: osd.sh volume up|down|mute   or   osd.sh brightness up|down
wob="$XDG_RUNTIME_DIR/wob.sock"

case "$1 $2" in
  "volume up")      wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+ ;;
  "volume down")    wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- ;;
  "volume mute")    wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle ;;
  "brightness up")  brightnessctl -q set 5%+ ;;
  "brightness down") brightnessctl -q set 5%- ;;
  *) echo "usage: $0 volume up|down|mute | brightness up|down" >&2; exit 1 ;;
esac

[ -p "$wob" ] || exit 0
if [ "$1" = volume ]; then
  # "Volume: 0.45" or "Volume: 0.45 [MUTED]"; show 0 when muted
  wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{ print ($3 == "[MUTED]") ? 0 : int($2 * 100 + 0.5) }' > "$wob"
else
  brightnessctl -m | cut -d, -f4 | tr -d % > "$wob"
fi
