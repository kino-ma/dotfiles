{ pkgs, ... }:

{
  imports = [ ./common.nix ];

  home.packages = with pkgs;
    [
      iterm2
      pinentry_mac
    ];
}
