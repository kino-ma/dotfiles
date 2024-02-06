{ pkgs, ... }: {
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = [];

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true;  # default shell on catalina
  # programs.fish.enable = true;

  # Set Git commit hash for darwin-version.
  # Not using
  #system.configurationRevision = self.rev or self.dirtyRev or null;

  # Added
  users.users.kino-ma =
    { home = "/Users/kino-ma";
    };

  home-manager.users."kino-ma" = import ./home.nix;

  nixpkgs.config =
    { allowUnfree = true;
      allowBroken = true;
    };

  system.defaults.dock.orientation = "left";
}
