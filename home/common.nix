{ pkgs, ... }:

{
  home.packages = with pkgs;
    [
      bc
      curl
      git
      gnupg
      htop
      hub
      home-manager
      nixpkgs-fmt
      tldr
      tmux
      vscode

      # Unfree packages
      discord
      slack
      zoom-us
    ];

  programs.home-manager.enable = true;

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
  };

  programs.zsh = import ./programs/zsh.nix {
    inherit pkgs;
  };
}
