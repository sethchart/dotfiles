#!/bin/sh
# Claude Code via the native installer (~/.local/bin/claude); it updates itself.
command -v claude >/dev/null || [ -x "$HOME/.local/bin/claude" ] ||
  curl -fsSL https://claude.ai/install.sh | bash
