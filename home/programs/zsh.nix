{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;

    defaultKeymap = "viins";

    dotDir = "${config.home.homeDirectory}/.config/zsh";

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
      DEFAULT_USERS = "kino-ma kinoma";
      DOCKER_HOST = "unix://\${HOME}/.colima/default/docker.sock";
    };

    siteFunctions = {
      "fzf-select-history" = ''
        BUFFER=$(history -n -r 1 | fzf --query "$LBUFFER" --tiebreak index)
        CURSOR=$#BUFFER
        zle reset-prompt
      '';

      "fzf-cdr" = ''
        local selected_dir=$(cdr -l | awk '{ print $2 }' | fzf --reverse)
        if [ -n "$selected_dir" ]; then
            BUFFER="cd $selected_dir"
            zle accept-line
        fi
        zle clear-screen
      '';
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
      lg = "lazygit";
    };

    completionInit = ''
      {
        zcompdump="${"ZDOTDIR:-$HOME"}/.zcompdump"
        if [[ -s "$zcompdump" && (! -s "$zcompdump.zwc" || "$zcompdump" -nt "$zcompdump.zwc") ]]; then
          zcompile "$zcompdump"
        fi
      } &!

      autoload -Uz compinit
      if [ "$(uname)" = 'Darwin' ]; then
          if [ $(date +'%j') != $(/usr/bin/stat -f '%Sm' -t '%j' ${"ZDOTDIR:-$HOME"}/.zcompdump) ]; then

          compinit
          else
          compinit -C
          fi
      else
          compinit -C
      fi
    '';

    # Export LSCOLORS here instead of sessionVariables, because some plugins seem to override them.
    initContent = ''
      if [[ -n $GHOSTTY_RESOURCES_DIR ]]; then
        source "$GHOSTTY_RESOURCES_DIR"/shell-integration/zsh/ghostty-integration 2>/dev/null || \
          source "''${GHOSTTY_RESOURCES_DIR%/ghostty}"/shell-integration/ghostty-integration.zsh 2>/dev/null
      fi

      . ${../../.zsh/functions.zsh}
      . ${../../.zsh/keys.zsh}
      . ${../../.zsh/gpg.zsh}
      . ${../../.zsh/gpg.zsh}
      . ${../../.zsh/history.zsh}
      . ${../../.zsh/notify.zsh}
      unset RPS1
      unset RPROMPT

      # agnoster theme's prompt_git() calls parse_git_dirty() (git status --porcelain)
      # and vcs_info with check-for-changes, which are slow on large repos.
      # Override with a lightweight version that only shows the branch name.
      prompt_git() {
        (( $+commands[git] )) || return
        if [[ "$(command git config --get oh-my-zsh.hide-status 2>/dev/null)" = 1 ]]; then
          return
        fi
        local PL_BRANCH_CHAR
        () {
          local LC_ALL="" LC_CTYPE="en_US.UTF-8"
          PL_BRANCH_CHAR=$'\ue0a0'
        }
        local ref
        if [[ "$(command git rev-parse --is-inside-work-tree 2>/dev/null)" = "true" ]]; then
          ref=$(command git symbolic-ref --short HEAD 2>/dev/null) || \
          ref="◈ $(command git describe --exact-match --tags HEAD 2>/dev/null)" || \
          ref="➦ $(command git rev-parse --short HEAD 2>/dev/null)"
          prompt_segment "$AGNOSTER_GIT_CLEAN_BG" "$AGNOSTER_GIT_CLEAN_FG" "$PL_BRANCH_CHAR ''${ref:gs/%/%%}"
        fi
      }

      for script in $HOME/.config/op/plugins.sh; do
          if [[ -f "$script" ]]; then
              . $script
          fi
      done

      # Copied from auto-generated alias manually
      chpwd() { eza '--icons' '--git' '--classify' '--group-directories-first'; }

      if [[ "$TERM_PROGRAM" == "vscode" ]]; then
      # Disable RPROMPT in VS Code (causes detection issues)
      unset RPROMPT
      unset RPS1

      # Load VS Code shell integration
      [[ -f "$(code --locate-shell-integration-path zsh)" ]] && \
          . "$(code --locate-shell-integration-path zsh)"
      fi
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

  };
}
