{ config, pkgs, ... }: {
  imports = [
    ../../platforms/darwin-common.nix
  ];

  home-manager.users."kino-ma" = import ./home.nix;
  system.stateVersion = 5;
}
