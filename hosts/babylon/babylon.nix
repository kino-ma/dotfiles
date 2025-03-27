{ pkgs, ... }: {
  imports = [
    ../../platforms/darwin-common.nix
  ];

  home-manager.users."kino-ma" = import ../../home/darwin.nix;
  system.stateVersion = 5;
}
