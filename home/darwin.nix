{ pkgs, ... }:

{
  imports = [ ./common.nix ];

  home.stateVersion = "24.05";

  home.packages = with pkgs;
    [
      colima
      darwin.trash
      docker
      docker-credential-helpers
      iproute2mac
      obsidian
      pinentry_mac
      postman

      # Unfree packages
      _1password-cli
      raycast
      vscode
    ];

  home.file.".gnupg/gpg-agent.conf".text =
    ''
      pinentry-program ${pkgs.pinentry_mac}/Applications/pinentry-mac.app/Contents/MacOS/pinentry-mac
      enable-ssh-support
    '';
}
