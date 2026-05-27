{ pkgs, lib, config, ... }:

let

  scroll-reverser = pkgs.callPackage ../pkgs/scroll-reverser { };

in
{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    scroll-reverser
    colima
  ];

  # nix.package = pkgs.nix;

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true; # default shell on catalina
  # programs.fish.enable = true;

  # Set Git commit hash for darwin-version.
  # Not using
  #system.configurationRevision = self.rev or self.dirtyRev or null;

  fonts.packages = [
    pkgs.nerd-fonts._0xproto
    pkgs.monaspace
  ];

  nixpkgs.config = {
    allowUnfree = true;
    allowBroken = true;
    permittedInsecurePackages = [
      "lima-full-1.2.2"
      "lima-additional-guestagents-1.2.2"
    ];
  };

  system.primaryUser = lib.mkDefault "kino-ma";
  system.defaults.dock.orientation = "right";
  system.defaults.dock.autohide = false;
  system.defaults.screencapture.location = "${config.users.users.kino-ma.home}/Documents/screenshots";
  system.defaults.NSGlobalDomain.ApplePressAndHoldEnabled = false;
  system.defaults.NSGlobalDomain.KeyRepeat = 2;
  system.defaults.NSGlobalDomain.InitialKeyRepeat = 15;
}
