{ pkgs, ...}:

{
  home.stateVersion = "24.05"; 
  home.packages = with pkgs; [ git gnupg iterm2 slack discord ];
  programs.neovim = import ./neovim.nix;

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

  programs.gpg =
    { enable = true;
      publicKeys =
        [ { source = ./keys/gpg/pubkey.txt; trust = "ultimate"; }
        ];
    };

  #services.gpg-agent =
  #  { enable = true;
  #    enableSshSupport = true;
  #    enableZshIntegration = true;
  #    extraConfig = "pinentry-program ${pkgs.pinentry-mac}";
  #  };
}
