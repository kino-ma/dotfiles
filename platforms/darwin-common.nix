{ pkgs, lib, ... }:

let

  scroll-reverser = pkgs.callPackage ../pkgs/scroll-reverser { };

in
{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = [
    scroll-reverser
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
  };

  system.primaryUser = lib.mkDefault "kino-ma";
  system.defaults.dock.orientation = "right";
  system.defaults.screencapture.location = "$HOME/Documents/screenshots";
  system.defaults.NSGlobalDomain.ApplePressAndHoldEnabled = false;
  system.defaults.NSGlobalDomain.KeyRepeat = 2;
  system.defaults.NSGlobalDomain.InitialKeyRepeat = 15;
}
