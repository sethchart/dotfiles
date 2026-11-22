#!/bin/bash
# qcli, my Qobuz command-line client, built from its private repo
# (github.com/sethchart/qcli). Fetching it needs GitHub credentials:
# `gh auth login` and `gh auth setup-git` on each machine.
# To update: bump rev below; chezmoi re-runs this script when it changes.
# Named install-user-* so it runs after install-rust (rustup).
set -euo pipefail

rev=7b98fbbf9026514b17c7f9d098e249a2f1f0fdc4

# shellcheck source=/dev/null
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"
if ! command -v cargo >/dev/null; then
  echo "qcli: cargo not found; install Rust first, then re-run chezmoi apply" >&2
  exit 1
fi

# Let git (with gh's credential helper) fetch the private repo.
CARGO_NET_GIT_FETCH_WITH_CLI=true \
  cargo install --locked --git https://github.com/sethchart/qcli --rev "$rev" qcli
