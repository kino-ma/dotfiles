{ pkgs, ... }:

{
  imports = [ ./common.nix ];

  home.stateVersion = "24.05";

  home.packages = with pkgs;
    [
      colima
      darwin.iproute2mac
      darwin.trash
      docker
      docker-credential-helpers
      pinentry_mac

      # Unfree packages
      _1password
      raycast
      vscode
    ];

  home.file.".gnupg/gpg-agent.conf".text =
    ''
      pinentry-program ${pkgs.pinentry_mac}/Applications/pinentry-mac.app/Contents/MacOS/pinentry-mac
      enable-ssh-support
    '';
}
