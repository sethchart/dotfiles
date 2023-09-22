# Oh My ZSH
## Configuration
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="zhann"
zstyle ':omz:update' mode auto      # update automatically without asking
zstyle ':omz:update' frequency 5
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="yyyy-mm-dd"

# Plugins
plugins=( git zsh-vi-mode )

# Source Oh My ZSH
source $ZSH/oh-my-zsh.sh

# User configuration
## Path
export PATH="/usr/local/opt/postgresql@11/bin:$PATH"
# Created by `pipx` on 2022-05-12 18:12:15
export PATH="$PATH:/Users/schart/.local/bin"
export PATH="/usr/local/opt/openjdk/bin:$PATH"

# Auto completion for pipx
eval "$(register-python-argcomplete pipx)"
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

autoload -Uz compinit
zstyle ':completion:*' menu select
fpath+=~/.zfunc

# Environment Variables
export JAVA_HOME=/Library/Java/JavaVirtualMachines/temurin-20.jdk/Contents/Home
export GITHUB_USER=sethchart
export GITHUB_TOKEN=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
