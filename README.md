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
- Claude Code skills in `~/.claude/skills` (add new ones with `chezmoi add`); `synced/`
  is ignored because Claude Code syncs those from the claude.ai account itself
- `run_once_after_install-rust.sh` installs Rust (stable, via rustup) into `~/.cargo`
- Feeds: Miniflux on the workstation, newsboat everywhere, and the Needle Drop
  → Qobuz automation (see below)

## Feeds (Miniflux)

News, podcasts, YouTube channels and RSS all live in Miniflux, which runs on
the workstation as rootless Podman containers (Miniflux + PostgreSQL in one
pod, `dot_config/containers/systemd/`, set up by
`run_onchange_after_user-miniflux.sh.tmpl`). It listens on 127.0.0.1:8080
only; `sudo tailscale serve --bg 8080` (once) publishes it on the tailnet at
the `miniflux.url` in `.chezmoidata/miniflux.yaml`. Images update themselves
(`podman-auto-update.timer`); Postgres stays on its major version.

Retention: everything, read or unread, is removed after 2 days unless
starred (`CLEANUP_*` in `miniflux.container.tmpl`); star anything worth keeping.

Clients: the web UI, newsboat (every machine; `v` opens videos/episodes in
mpv) and Capy Reader on the phone (with Tailscale).

`needledrop-to-qobuz` (hourly, `systemctl --user list-timers`) adds every
album The Needle Drop reviews to the Qobuz playlist "Needle Drop", so the
music can be heard before the review. State and misses:
`~/.local/state/needledrop-to-qobuz/`. Try it with `--dry-run`.

## Credentials

Secrets never go in this repo. One credential per client, so any one can be
revoked alone:

| Credential | Lives in | Used by | Renew / revoke |
|---|---|---|---|
| Miniflux password (`seth`) | login keyring (`secret-tool lookup service miniflux user seth`) | web login, newsboat | change it in Miniflux, then `secret-tool store --label=Miniflux service miniflux user seth` |
| Miniflux API key `needledrop` | `~/.config/miniflux/api-token` (0600) | needledrop-to-qobuz | Miniflux › Settings › API Keys |
| Miniflux API key `capy-phone` | Capy Reader on the phone | Capy Reader | Miniflux › Settings › API Keys |
| PostgreSQL password | `~/.config/miniflux/db.env` and `DATABASE_URL` in `miniflux.env` | Miniflux → its database (inside the pod only) | generated once; never typed |
| Qobuz token | `~/.local/state/qobuz-cli/credentials.toml` | `qobuz`, needledrop-to-qobuz | `qobuz login` |
| Qobuz web-player session | qobuz-cli's Firefox profile (`~/.local/state/qobuz-cli/firefox-profile`) | `qobuz play` | `qobuz player login` |
| Tailscale | the sign-in account; device keys in tailscaled | every device | admin console › Machines |
| SSH keys | one per device, on that device | see "SSH between machines" | remove from `private_dot_ssh/authorized_keys` |

Miniflux's Google Reader and Fever APIs are off. The Miniflux password is
also written to `miniflux.env` for the very first start (to create the
user) and removed from there automatically once the keyring copy works.

## SSH between machines

`ssh laptop`, `ssh workstation`, `ssh pi` and `ssh phone` (`~/.ssh/config`) use
DHCP-reserved IPs on the home router; mDNS `.local` names don't cross the mesh
Wi-Fi. sshd accepts keys only. `~/.ssh/authorized_keys` lists one public key per
device; private keys stay on their device and never go in this repo.
`~/.ssh/known_hosts_home` holds each device's host key, so connecting to a
device for the first time never asks to confirm its fingerprint.

New machine: `ssh-keygen -t ed25519 -C seth@<host>`, add the `.pub` line to
`private_dot_ssh/authorized_keys`, push, `chezmoi update` everywhere. Tick
"automatically unlock" when gcr first asks for the passphrase; the login
keyring is unlocked at tty login (PAM), so no prompts after that.

Phone (Termux, not managed by chezmoi): `pkg install openssh`, `sshd` (port
8022), `termux-wake-lock` to keep it alive. After keys change, refresh it with

    curl -fsSL https://raw.githubusercontent.com/sethchart/dotfiles/main/private_dot_ssh/authorized_keys -o ~/.ssh/authorized_keys
    curl -fsSL https://raw.githubusercontent.com/sethchart/dotfiles/main/private_dot_ssh/config -o ~/.ssh/config
    curl -fsSL https://raw.githubusercontent.com/sethchart/dotfiles/main/private_dot_ssh/known_hosts_home -o ~/.ssh/known_hosts_home

Password logins are off via `$PREFIX/etc/ssh/sshd_config.d/10-keys-only.conf`.
The phone's key has no passphrase (Android encrypts its storage).

Raspberry Pi (Debian, not managed by chezmoi): after keys change, refresh it with

    ssh pi 'cat > ~/.ssh/authorized_keys' < ~/.ssh/authorized_keys

Password logins are off via `/etc/ssh/sshd_config.d/10-keys-only.conf`.
