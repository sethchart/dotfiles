#!/bin/sh
# Dark mode preference for GTK apps and the xdg portal (Firefox etc.).
# Stored in dconf rather than a file, so chezmoi sets it once per machine.
gsettings set org.gnome.desktop.interface color-scheme prefer-dark
gsettings set org.gnome.desktop.interface gtk-theme Adwaita-dark
