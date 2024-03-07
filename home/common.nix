{ pkgs, ... }:

{
  home.packages = with pkgs;
    [
      bc
      curl
      dogdns
      duf
      du-dust
      fd
      git
      gnupg
      gping
      htop
      hub
      home-manager
      httpie
      hyperfine
      nixpkgs-fmt
      procs
      python3
      tldr
      tmux
      vscode

      # Unfree packages
      discord
      slack
      zoom-us
    ];

  programs.home-manager.enable = true;

  programs.bat = {
    enable = true;
    extraPackages = with pkgs.bat-extras; [
      batgrep
      batman
      batpipe
      batwatch
      batdiff
      prettybat
    ];
  };

  programs.eza = {
    enable = true;
    enableAliases = true;

    git = true;
    icons = true;

    extraOptions = [
      #"--absolute=follow"
      "--classify"
      "--group-directories-first"
    ];
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    changeDirWidgetCommand = "fd --type d";
    defaultCommand = "fd --type f";
  };


  programs.git = import ./programs/git.nix;

  programs.gpg = import ./programs/gpg.nix;

  programs.neovim = import ./programs/neovim.nix {
    inherit pkgs;
  };

  programs.tmux = {
    enable = true;
    prefix = "C-z";
    clock24 = true;
    mouse = true;
    newSession = true;
    terminal = "screen-256color";
  };

  programs.zsh = import ./programs/zsh.nix {
    inherit pkgs;
  };
}
