{ pkgs, ... }: {
  imports = [
    ../../platforms/darwin-common.nix
  ];

  home-manager.users."kino-ma" = import ../../home/darwin-personal.nix;
  system.stateVersion = 5;
}
