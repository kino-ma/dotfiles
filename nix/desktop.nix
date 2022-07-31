{ pkgs, ... }:

{
  home.packages = (with pkgs; [
    discord
    google-chrome
    pinentry-gnome
    slack
    tldr
    vscode
    xclip
    zoom
  ]);
}
