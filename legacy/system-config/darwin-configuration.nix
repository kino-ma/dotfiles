{ config, pkgs, ... }:

{
  imports = [
    <home-manager/nix-darwin>
    "/Users/kino-ma/.nixpkgs/local-configuration.nix"
  ];
  users.users.kino-ma = {
    name = "kino-ma";
    home = "/Users/kino-ma";
  };

  # Home Manager
  home-manager.users.kino-ma = { config, pkgs, ... }: {
      imports = [
        /Users/kino-ma/.config/nixpkgs/home.nix
        /Users/kino-ma/.config/nixpkgs/custom.nix
      ];

      home.homeDirectory = "/Users/kino-ma";
  };

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = [];

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  # environment.darwinConfig = "/Users/kino-ma/.config/nixpkgs/darwin/configuration.nix";

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;

  # Create /etc/bashrc that loads the nix-darwin environment.
  programs.zsh.enable = true;  # default shell on catalina
  # programs.fish.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
