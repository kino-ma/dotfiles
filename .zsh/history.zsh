# Bind ^r / ^q to invoke history search functions defined in zsh.nix

# Search history by fzf
zle -N fzf-select-history
bindkey '^r' fzf-select-history

# Search directory history by fzf
autoload -Uz chpwd_recent_dirs cdr
zle -N fzf-cdr
setopt noflowcontrol
bindkey '^q' fzf-cdr
