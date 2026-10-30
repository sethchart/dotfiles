#!/bin/sh
# Rust via rustup (~/.cargo, ~/.rustup); `rustup update` keeps it current.
# --no-modify-path: dot_bashrc and dot_bash_profile already source ~/.cargo/env.
command -v rustup >/dev/null || [ -x "$HOME/.cargo/bin/rustup" ] ||
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs |
    sh -s -- -y --no-modify-path --default-toolchain stable --profile default
