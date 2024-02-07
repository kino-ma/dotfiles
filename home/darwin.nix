{ pkgs, ... }:

{
  imports = [ ./common.nix ];

  home.packages = with pkgs;
    [
      iterm2
      pinentry_mac
    ];

  home.file.".gnupg/gpg-agent.conf".text =
    ''
      pinentry-program ${pkgs.pinentry_mac}/Applications/pinentry-mac.app/Contents/MacOS/pinentry-mac
      enable-ssh-support
    '';
}