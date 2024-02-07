{ pkgs, ... }:

{
  home.stateVersion = "24.05";
  home.packages = with pkgs;
    [
      git
      gnupg
      home-manager
      nixpkgs-fmt
      vscode

      # Unfree packages
      discord
      slack
      zoom-us
    ];

  home.sessionVariables = {
    SSH_AUTH_SOCK = "$HOME/.gnupg/S.gpg-agent.ssh";
  };

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
