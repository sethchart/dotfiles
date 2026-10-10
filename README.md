# dotfiles

My Arch Linux + sway configs, managed with [chezmoi](https://www.chezmoi.io/)
and shared between `laptop` and `desktop`.

## New machine

    sudo pacman -S chezmoi
    chezmoi init --apply sethchart

## Daily use

    chezmoi edit ~/.config/sway/config   # edit the managed copy
    chezmoi apply                        # write changes to ~
    chezmoi add ~/.config/some/file      # start managing a file, or re-add after editing it directly
    chezmoi diff                         # what apply would change
    chezmoi update                       # pull from GitHub and apply

    chezmoi cd                           # shell in the repo to commit and push
    git add -A && git commit -m "..." && git push

## Machine differences

Files ending in `.tmpl` are templates. Per-machine sections use the hostname:

    {{ if eq .chezmoi.hostname "laptop" }} ... {{ end }}

Currently only `~/.config/sway/config` has any (the touchpad settings).

## What's here

- sway (config, keybinding cheat sheet, file picker), tmux, Neovim, bash
- PipeWire audio quality settings, default apps, GTK dark mode
- `run_once_set-dark-mode.sh` sets the dark-mode preference once per machine
