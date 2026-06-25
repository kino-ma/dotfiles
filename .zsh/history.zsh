# Bind ^r / ^q to invoke history search functions defined in zsh.nix

# Search history by fzf
zle -N fzf-select-history
bindkey '^r' fzf-select-history

# Search directory history by fzf
autoload -Uz chpwd_recent_dirs cdr
chpwd_functions+=chpwd_recent_dirs
zstyle ":chpwd:*" recent-dirs-max 500
zstyle ":chpwd:*" recent-dirs-default true
zstyle ":completion:*" recent-dirs-insert always
zle -N fzf-cdr
setopt noflowcontrol
bindkey '^q' fzf-cdr
