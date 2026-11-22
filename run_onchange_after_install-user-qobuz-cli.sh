#!/bin/bash
# qobuz-cli (the `qobuz` command), my Qobuz command-line client, built from
# its private repo (github.com/sethchart/qobuz-cli). Fetching it needs GitHub
# credentials: `gh auth login` and `gh auth setup-git` on each machine.
# To update: bump rev below; chezmoi re-runs this script when it changes.
# Named install-user-* so it runs after install-rust (rustup).
set -euo pipefail

rev=98ccfa80c4691fd77adfe94419a6d750e499235c

# shellcheck source=/dev/null
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"
if ! command -v cargo >/dev/null; then
  echo "qobuz-cli: cargo not found; install Rust first, then re-run chezmoi apply" >&2
  exit 1
fi

# Let git (with gh's credential helper) fetch the private repo.
CARGO_NET_GIT_FETCH_WITH_CLI=true \
  cargo install --locked --git https://github.com/sethchart/qobuz-cli --rev "$rev" qobuz-cli

# The project was called qcli until 2026-11-22; remove the old binary.
if cargo install --list | grep -q '^qcli v'; then
  cargo uninstall qcli
fi
