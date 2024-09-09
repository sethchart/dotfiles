# fzf configuration
if type rg &> /dev/null; then
  export FZF_DEFAULT_COMMAND='rg --files'
  export FZF_DEFAULT_OPTS='-m'
fi
# Enable the subsequent settings only in interactive sessions
case $- in
  *i*) ;;
    *) return;;
esac

# Oh My Bash
export OSH=/home/seth/.oh-my-bash
OSH_THEME="powerline"
COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="yyyy-mm-dd"
OMB_USE_SUDO=true
completions=(
  git
  composer
  ssh
)
aliases=(
  general
)
plugins=(
  git
  bashmarks
)
source "$OSH"/oh-my-bash.sh
export LANG=en_US.UTF-8
# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='vim'
fi

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
