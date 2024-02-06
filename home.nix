{ pkgs, ...}:

{
  home.stateVersion = "24.05"; 
  home.packages = with pkgs;
    [ git
      gnupg
      home-manager
      iterm2
      pinentry_mac
      vscode

      # Unfree packages
      _1password-gui
      discord
      slack
      zoom-us
    ];

    home.sessionVariables = {
      SSH_AUTH_SOCK = "$HOME/.gnupg/S.gpg-agent.ssh";
    };

  programs.home-manager.enable = true;

  programs.neovim = import ./neovim.nix;

  # Git settings
  programs.git =
    { enable = true;
      userName = "kino-ma";
      userEmail = "ma@kino.ma"; 
      signing =
        { key = "F0D7A2F02CAE648A";
          signByDefault = true;
        };

      extraConfig =
        ''
          [pull]
          ff = only

          [init]
          defaultBranch = true
        '';

      aliases =
        { c = "commit -m";
          cn = "commit --no-gpg-sign -m";
          s = "status";
          d = "diff";
          ds = "diff --staged";

          c-feat = ''!"${./shell-helpers/commit-with-prefix.sh} feat"'';
          c-fix = ''!"${./shell-helpers/commit-with-prefix.sh} fix"'';
          c-refactor = ''!"${./shell-helpers/commit-with-prefix.sh} refactor"'';
          c-test = ''!"${./shell-helpers/commit-with-prefix.sh} test"'';
          c-perf = ''!"${./shell-helpers/commit-with-prefix.sh} perf"'';
          c-style = ''!"${./shell-helpers/commit-with-prefix.sh} style"'';
          c-docs = ''!"${./shell-helpers/commit-with-prefix.sh} docs"'';
          c-build = ''!"${./shell-helpers/commit-with-prefix.sh} build"'';
          c-ci = ''!"${./shell-helpers/commit-with-prefix.sh} ci"'';

          force-clean = "clean -fdX";
          gr = "log --graph --date=short --decorate=short --pretty=format:'%Cgreen%h %Creset%cd %Cblue%cn %Cred%d %Creset%s'";
          m-init = "submodule update --init --recursive";
        };

      ignores =
      	[
          "*.*~"
          "*.swp"
          ".vscode"
          ".DS_Store"
        ];
    };

  # GnuPG settings
  programs.gpg =
    { enable = true;
      publicKeys =
        [ { source = ./keys/gpg/pubkey.txt; trust = "ultimate"; }
        ];
    };
  home.file.".gnupg/gpg-agent.conf".text =
    ''
      pinentry-program ${pkgs.pinentry_mac}/Applications/pinentry-mac.app/Contents/MacOS/pinentry-mac
      enable-ssh-support
    '';

}