{ pkgs, ... }: {
  imports = [
    ../../platforms/darwin-common.nix
  ];

  system.stateVersion = 5;

  home-manager.users."kino-ma" = import ../../home/darwin.nix;
  users.users.kino-ma.home = "/Users/kino-ma";
}
