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
alias vim_='"vim"'

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

# options about history
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

TERM=xterm

VIMTMP="$HOME/.vim/tmp"

# Ctrl+rでヒストリーのインクリメンタルサーチ、Ctrl+sで逆順
bindkey '^r' history-incremental-pattern-search-backward
bindkey '^s' history-incremental-pattern-search-forward

export PATH="$HOME/go/bin:$PATH"
export PATH="$HOME/.ghcup/bin:$PATH"
export PATH="$HOME/.rbenv/shims:/usr/local/bin:$PATH"
export PATH="$HOME/.cabal/bin:$PATH"

export PATH="/Users/kino-ma/google-cloud-sdk/bin:$PATH"



source ~/.zsh/*.*sh
