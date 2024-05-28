{ pkgs, lib, ... }:

{
  imports = [ ./nixos-common.nix ];

  home.packages = (with pkgs; [
    pinentry-gnome3
    vscode
    xclip
    xdotool

    # Unfree packages
    google-chrome
  ]);

}
