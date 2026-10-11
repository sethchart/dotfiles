# dotfiles

My Arch Linux + sway configs, managed with [chezmoi](https://www.chezmoi.io/)
and shared between `laptop` and `workstation`.

## New machine

    sudo pacman -S chezmoi git
    chezmoi init --apply sethchart

This installs every package in `.chezmoidata/packages.yaml` (asks for your
sudo password), builds yay if needed, then writes the configs.

## Daily use

    chezmoi edit ~/.config/sway/config   # edit the managed copy
    chezmoi apply                        # write changes to ~
    chezmoi add ~/.config/some/file      # start managing a file, or re-add after editing it directly
    chezmoi diff                         # what apply would change
    chezmoi update                       # pull from GitHub and apply

    chezmoi cd                           # shell in the repo to commit and push
    git add -A && git commit -m "..." && git push

## Packages

`.chezmoidata/packages.yaml` lists packages for every machine (`common`),
per-hostname extras (`laptop`, `workstation`), AUR packages (`aur`, same
shape) and packages to uninstall (`remove`). After editing it, `chezmoi apply`
installs anything missing and uninstalls anything on `remove`; packages that
are simply dropped from the list stay installed.

To spot packages installed but not in the list:

    pacman -Qqen | sort | comm -23 - <(grep -oP '^\s+- \K\S+' "$(chezmoi source-path)/.chezmoidata/packages.yaml" | sort)

(microcode shows up here since it's picked automatically.)

## Machine differences

Files ending in `.tmpl` are templates. Per-machine sections use the hostname:

    {{ if eq .chezmoi.hostname "laptop" }} ... {{ end }}

Currently only `~/.config/sway/config` has any (the touchpad settings).

## What's here

- sway (config, keybinding cheat sheet, file picker), tmux, Neovim, bash
- PipeWire audio quality settings, default apps, GTK dark mode
- `run_once_set-dark-mode.sh` sets the dark-mode preference once per machine
- keyd: Super+C/V/X/A/Z act as Ctrl (system config in `run_onchange_after_system-settings.sh.tmpl`,
  per-app overrides in `~/.config/keyd/app.conf`)
- `run_once_after_install-claude-code.sh` installs Claude Code with its native installer;
  opencode comes from the package list
