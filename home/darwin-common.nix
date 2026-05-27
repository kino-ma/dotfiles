{ pkgs, ... }:

{
  imports = [ ./common.nix ];

  home.stateVersion = "24.05";

  home.packages = with pkgs;
    [
      ccusage
      darwin.trash
      docker
      docker-credential-helpers
      iproute2mac
      obsidian
      pinentry_mac
      postman
      yubikey-manager

      # Unfree packages
      _1password-cli
      arc-browser
      raycast
      vscode
    ];

  home.file.".gnupg/gpg-agent.conf".text =
    ''
      pinentry-program ${pkgs.pinentry_mac}/Applications/pinentry-mac.app/Contents/MacOS/pinentry-mac
      enable-ssh-support
    '';

  programs.claude-code = import ./programs/claude;
}
