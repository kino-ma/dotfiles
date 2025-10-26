{ pkgs, ... }:

{
  imports = [ ./darwin-common.nix ];

  home.packages = with pkgs;
    [
      # Unfree packages
      discord
    ];
}
