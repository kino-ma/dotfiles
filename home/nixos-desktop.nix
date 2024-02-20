{ pkgs, lib, ... }:

{
  imports = [ ./nxos-common.nix ];

  home.packages = (with pkgs; [
    pinentry-gnome
    vscode
    xclip
    xdotool

    # Unfree packages
    google-chrome
  ]);

}
