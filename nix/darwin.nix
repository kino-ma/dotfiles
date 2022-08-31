{ pkgs, ... }:

{
  home.packages = (with pkgs; [
    docker
    iterm2
    pinentry_mac
    tldr
    vscode
  ]);
}
