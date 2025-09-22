git-commit-with-prefix() {
    GIT_PREFIX=$1
    GIT_COMMIT_MESSAGE=$2
    shift 2
    git commit -m "[$GIT_PREFIX] $GIT_COMMIT_MESSAGE" "$@"
}

prompt_status () {
	local -a symbols
	[[ $RETVAL -ne 0 ]] && symbols+="%{%F{blue}%}✘" 
	[[ $UID -eq 0 ]] && symbols+="%{%F{yellow}%}⚡" 
	[[ $(jobs -l | wc -l) -gt 0 ]] && symbols+="%{%F{cyan}%}⚙" 
	[[ -n "$symbols" ]] && prompt_segment black default "$symbols"
}

prompt_context() {
    # If the current user is not in default users (kinoma & kino-ma), then display the name
    # Also, if the session is run with privilege, display in yellow text
    if [[ ! ${DEFAULT_USERS[@]} =~ "$USERNAME" || -n "$SSH_CLIENT" ]]; then
        prompt_segment black default "%B%(!.%{%F{yellow}%}.)%n@%m%b"
    fi
}

prompt_dir() {
    prompt_segment blue default '%~'
}

prompt_end() {
    if [[ -n $CURRENT_BG ]]; then
        echo -n " %{%k%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR"
    else
        echo -n "%{%k%}"
    fi
    echo -n "%{%f%}"
    CURRENT_BG=''

    printf "\n →"
}

alias xbrew='BREW_PREFIX=/usr/local arch -x86_64 /usr/local/Homebrew/bin/brew'
alias k='kubectl'

clean_controlmasters() {
    setopt localoptions rmstarsilent
    rm -iv "$HOME/.ssh/.controlmasters/"*
}

use_flake() {
    echo 'use flake' > .envrc && direnv allow .
}
