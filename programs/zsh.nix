{ pkgs }:

{
  enable = true;

  defaultKeymap = "viins";

  dotDir = ".config/zsh";

  autocd = true;
  enableAutosuggestions = true;
  enableSyntaxHighlighting = true;

  history.extended = true;

  oh-my-zsh = {
    enable = true;
    theme = "agnoster";
  };

  shellAliases = {
    xbrew = "BREW_PREFIX=/usr/local arch -x86_64 /usr/local/Homebrew/bin/brew";
  };

  completionInit = ''
    {
      zcompdump="${ZDOTDIR:-$HOME}/.zcompdump"
      if [[ -s "$zcompdump" && (! -s "$zcompdump.zwc" || "$zcompdump" -nt "$zcompdump.zwc") ]]; then
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
  '';

  # Export LSCOLORS here instead of sessionVariables, because some plugins seem to override them.
  loginExtra = ''
    export LSCOLORS="ExGxdxdxCxDxDxBxBxegeg"
    . ${../.zsh/keys.zsh}
    . ${../.zsh/gpg.zsh}
    . ${../.zsh/functions.zsh}
  '';
}
