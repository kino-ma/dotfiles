{ pkgs, ... }:

{
  home.packages = (with pkgs; [
    iterm2
    pinentry_mac
    tldr
    vscode
  ]);
}
