# set prompt
PROMPT=$'%{\e[01;34m%}%*%{\e[00m%} %{\e[00;32m%}%c%{\e[00m%} $ '

# dan't log out with control+D
setopt IGNOREEOF

# correct when on typo
setopt correct

# auto cd
setopt auto_cd

alias ls='ls --color=auto'
alias la='ls -al'

alias vim="nvim"
alias vim_="/usr/local/bin/vim"

alias ssh-cam='gcloud beta compute ssh --zone "asia-northeast1-b" "camera-man-dev" --project "upbeat-repeater-291507"'

eval "$(hub alias -s)"

function chpwd() {
    if [ $(ls | wc -l) -le 40 -a $PWD==$HOME ]
    then
        ls
    fi
}


function cg() {
    cd $(git rev-parse --show-toplevel)
 }

function lg() {
    ls -a | grep -E $1
}

# mkdir and cd
function mkcd() {
  if [[ -d $1 ]]; then
    echo "$1 already exists!"
    cd $1
  else
    mkdir -p $1 && cd $1
  fi
}

function reload() {
    exec $SHELL -l
}

function cattmp() {
    cat $VIMTMP/$1'~'
}

# hokan
autoload -U compinit
compinit

#emacs-like keybind
bindkey -e

# options about history
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

TERM=xterm

# backspace,deleteキーを使えるように
stty erase ^H
stty erase "^?"
bindkey "^D" delete-char-or-list
bindkey "^H" backward-delete-char
bindkey "" backward-delete-char


VIMTMP="$HOME/.vim/tmp"

# Ctrl+rでヒストリーのインクリメンタルサーチ、Ctrl+sで逆順
bindkey '^r' history-incremental-pattern-search-backward
bindkey '^s' history-incremental-pattern-search-forward

export PATH="$HOME/go/bin:$PATH"
export PATH="$HOME/.ghcup/bin:$PATH"
export PATH="$HOME/.rbenv/shims:/usr/local/bin:$PATH"
export PATH="$HOME/.cabal/bin:$PATH"

# replace Mac utils with GNU utils
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
export PATH="/usr/local/opt/binutils/bin:$PATH"
export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"

export PATH="/Users/kino-ma/google-cloud-sdk/bin:$PATH"



export LC_ALL=en_US.UTF-8



# test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
# 
# if (which zprof > /dev/null 2>&1) ;then
#   zprof
# fi

# Git-Flow AutoComplete
source ~/.zsh/*.*sh

export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/openssl@1.1/lib"
export CPPFLAGS="-I/usr/local/opt/openssl@1.1/include"
export PKG_CONFIG_PATH="/usr/local/opt/openssl@1.1/lib/pkgconfig"
export PATH="/usr/local/Cellar/pyenv/1.2.18/libexec/pyenv:$PATH"
export PATH="$HOME/.pyenv/shims:$PATH"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/kino-ma/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/kino-ma/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/kino-ma/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/kino-ma/google-cloud-sdk/completion.zsh.inc'; fi
