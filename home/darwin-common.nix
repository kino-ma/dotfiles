{ pkgs, ... }:

{
  imports = [
    ./common.nix

    ./programs/claude
    ./programs/cmux
  ];

  home.stateVersion = "24.05";

  home.packages = with pkgs; [
    ccusage
    cmux
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

  home.file.".gnupg/gpg-agent.conf".text = ''
    pinentry-program ${pkgs.pinentry_mac}/Applications/pinentry-mac.app/Contents/MacOS/pinentry-mac
    enable-ssh-support
  '';
}
