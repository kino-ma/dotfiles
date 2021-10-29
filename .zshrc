# first load other rcs
# because some may include paths configuration
for rc in $HOME/.zsh/*.*sh
do
    source $rc
done

# make prompt expanded before manipulated
setopt PROMPT_SUBST

# set prompt
if [[ "$USER" == "kino-ma" ]]
then
    # If I am kino-ma
    # ```
    # 00:00:00 hostname:~
    # $
    # ```
    export PROMPT=$'%{\e[01;34m%}%*%{\e[00m%} %{\e[01;32m%}%m:%~%{\e[00m%}\n$ '
elif [[ "$USER" == "root" ]]
then
    # If I am root
    # ```
    # 00:00:00 root@hostname:~  # <- red color
    # $
    # ```
    export PROMPT=$'%{\e[01;34m%}%*%{\e[00m%} %{\e[01;33m%}$USER@%(!.%{\e[01;31m%}.%{\e[01;32m%})%m:%~%{\e[00m%}\n$ '
else
    # Other
    # ```
    # 00:00:00 hoge@hostname:~  # <- green color
    # $
    # ```
    export PROMPT=$'%{\e[01;34m%}%*%{\e[00m%} %{\e[01;33m%}$USER@%(!.%{\e[01;31m%}.%{\e[01;32m%})%m:%~%{\e[00m%}\n$ '
fi

# dan't log out with control+D
setopt IGNOREEOF

# correct when on typo
setopt correct

# auto cd
setopt auto_cd

if ls --version &> /dev/null
then
    alias ls='ls --color=auto'
elif ls -G &> /dev/null
then
    export LSCOLORS=ExGxdxdxCxDxDxBxBxegeg
    alias ls='ls -G'
fi

alias la='ls -al'

if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi

if which nvim &> /dev/null
then
    export EDITOR=$(which nvim)
    alias vim="nvim"
    alias vim_='"vim"'
elif which vim &> /dev/null
then
    export EDITOR=$(which vim)
fi

if which hub &> /dev/null
then
    eval "$(hub alias -s)"
fi

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

if [[ "$(uname)" == "Linux" ]]
then
    alias dcp="docker-compose"
else
    alias dcp="docker compose"
fi

# hokan
# load completion script in the background
{
  zcompdump="${ZDOTDIR:-$HOME}/.zcompdump"
  if [[ -s "$zcompdump" && (! -s "${zcompdump}.zwc" || "$zcompdump" -nt "${zcompdump}.zwc") ]]; then
    zcompile "$zcompdump"
  fi
} &!
autoload -Uz compinit
if [ "$(uname)" = 'Darwin' ]; then
    if [ $(date +'%j') != $(/usr/bin/stat -f '%Sm' -t '%j' ${ZDOTDIR:-$HOME}/.zcompdump) ]; then

    compinit
    else
    compinit -C
    fi
else
    compinit -C
fi

# options about history
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

TERM=xterm

VIMTMP="$HOME/.vim/tmp"

# Ctrl+r for backward history search and Ctrl+s for forward
bindkey '^r' history-incremental-pattern-search-backward
bindkey '^s' history-incremental-pattern-search-forward

export PATH="$HOME/go/bin:$PATH"
export PATH="$HOME/.ghcup/bin:$PATH"
export PATH="$HOME/.rbenv/shims:/usr/local/bin:$PATH"
export PATH="$HOME/.cabal/bin:$PATH"




if [[ -e ${ITERM2_INTEGRATIONS:=~/.iterm2_shell_integration.*sh} ]]
then
    . $ITERM2_integrations
fi
