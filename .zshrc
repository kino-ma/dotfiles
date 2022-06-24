# first load other rcs
# because some may include paths configuration
for rc in $(find -s "$HOME/.zsh" -type f -depth 1)
do
    source $rc
done

# make prompt expanded before manipulated
setopt PROMPT_SUBST

setopt share_history

# completion options
setopt list_types
setopt magic_equal_subst
zstyle ':completion::complete:*' use-cache true
zstyle ':completion:*' menu select

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


# completion sources
if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi

FPATH="~/.zsh/completion:$FPATH"

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
    if [ $(ls | wc -l) -le 40 -a "$PWD" != "$HOME" ]
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

alias dcp="docker-compose"

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
export LANG=en_US.UTF-8

TERM=xterm

VIMTMP="$HOME/.vim/tmp"

# Ctrl+r for backward history search and Ctrl+s for forward
bindkey '^r' history-incremental-pattern-search-backward
bindkey '^s' history-incremental-pattern-search-forward

# not portable, but it's ok because this is *`.zshrc`*
if [[ -e ${ITERM2_INTEGRATIONS:=~/.iterm2_shell_integration.zsh} ]]
then
    . $ITERM2_INTEGRATIONS
fi

# Load local script at the last
for rc in $(find -s "$HOME/.zsh" -name 'local/*.*sh')
do
    source $rc
done

# Automatically start tmux session on ssh
if [[ -n "$PS1" ]] && [[ -z "$TMUX" ]] && [[ -n "$SSH_CONNECTION" ]] && [[ "$LC_TERMINAL" == "iTerm2" ]] && which tmux >> /dev/null
then
    start_tmux() { tmux -CC attach || tmux -CC; }
    exec start_tmux
fi
