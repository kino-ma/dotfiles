{ pkgs, ... }:

{
  home.stateVersion = "24.05";
  home.packages = with pkgs;
    [
      git
      gnupg
      home-manager
      iterm2
      nixpkgs-fmt
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

  programs.neovim = import ./programs/neovim.nix {
    inherit pkgs;
  };
  programs.git = import ./programs/git.nix;
  programs.gpg = import ./programs/gpg.nix;
  home.file.".gnupg/gpg-agent.conf".text =
    ''
      pinentry-program ${pkgs.pinentry_mac}/Applications/pinentry-mac.app/Contents/MacOS/pinentry-mac
      enable-ssh-support
    '';

}
