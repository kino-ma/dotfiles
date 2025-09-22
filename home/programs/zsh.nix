{ pkgs }:

{
  enable = true;

  defaultKeymap = "viins";

  dotDir = ".config/zsh";

  autocd = true;
  syntaxHighlighting.enable = true;

  history.extended = true;

  autosuggestion = {
    enable = true;
  };

  oh-my-zsh = {
    enable = true;
    theme = "agnoster";
    plugins = [
      "copybuffer"
      "copypath"
      "copyfile"
      "dirhistory"
      "web-search"
      "sudo"
    ];
  };
  sessionVariables = {
    DEFAULT_USERS = [ "kino-ma" "kinoma" ];
  };

  shellAliases = {
    xbrew = "BREW_PREFIX=/usr/local arch -x86_64 /usr/local/Homebrew/bin/brew";
    dcp = "docker compose";
    cat = "bat";
    iso = "date '+%Y-%m-%dT%H:%M:%S%z'";
    pry = "poetry";
    uf = "git update-index --assume-unchanged flake.nix flake.lock";
    dr = "direnv reload";
    uff = "git update-index --no-assume-unchanged flake.nix flake.lock";

    # Git shortcuts
    d = "git d";
    s = "git s";
    ds = "git ds";
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
  initExtra = ''
    . ${../../.zsh/functions.zsh}
    . ${../../.zsh/keys.zsh}
    . ${../../.zsh/gpg.zsh}
    unset RPS1

    for script in $HOME/.config/op/plugins.sh; do
        if [[ -f "$script" ]]; then
            . $script
        fi
    done

    # Copied from auto-generated alias manually
    chpwd() { eza '--icons' '--git' '--classify' '--group-directories-first'; }
  '';

  envExtra = ''
    REPORTTIME=5
    ZSH_AUTOSUGGEST_MANUAL_REBIND=1
  '';

  loginExtra = ''
    wssh() {
      wezterm cli spawn --domain-name "SSH:$1" --new-window
    }
  '';

}
