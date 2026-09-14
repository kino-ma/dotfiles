{ pkgs, ... }:

{
  imports = [
    ./programs/bash.nix
    ./programs/git.nix
    ./programs/neovim.nix
    ./programs/zsh.nix
  ];

  home.packages = with pkgs; [
    bc
    clamp
    curl
    doggo
    duf
    dust
    fd
    file
    gh
    git
    git-lfs
    gnumake
    gnupg
    gping
    htop
    hub
    httpie
    hyperfine
    inetutils
    jq
    just
    lazygit
    nixfmt
    nixpkgs-fmt
    procs
    procps
    python3
    tldr
    tmux
  ];

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
    enableZshIntegration = true;

    git = true;
    icons = "auto";

    extraOptions = [
      #"--absolute=follow"
      "--classify"
      "--group-directories-first"
    ];
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    changeDirWidgetCommand = "fd --type d";
    defaultCommand = "fd --type f";
  };

  programs.gpg = import ./programs/gpg.nix;

  programs.wezterm = import ./programs/wezterm;

  programs.ripgrep = {
    enable = true;
    arguments = [
      "--hidden"
    ];
  };

  programs.ssh = import ./programs/ssh.nix;
  home.file.".ssh/.controlmasters/.keep".text = "";

  programs.tmux = {
    enable = true;
    prefix = "C-z";
    clock24 = true;
    mouse = true;
    newSession = true;
    terminal = "screen-256color";
  };
}
