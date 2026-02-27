{
  description = "Example Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/25.11";
    nixpkgs-2505.url = "github:NixOS/nixpkgs/25.05";
    nixpkgs-darwin.url = "github:NixOS/nixpkgs/nixpkgs-25.11-darwin";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin/nix-darwin-25.11";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs-darwin";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dotfiles-private = {
      url = "git+ssh://git@github.com/kino-ma/dotfiles-private?ref=main";
    };

  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      nixpkgs-2505,
      nix-darwin,
      nixpkgs-unstable,
      home-manager,
      dotfiles-private,
      ...
    }:

    let
      nixos-common = import ./platforms/nixos-common.nix;
      nixos-gui = import ./platforms/nixos-gui.nix;
      nixos-desktop = import ./platforms/nixos-desktop.nix;

      babylon = import ./hosts/babylon/babylon.nix;
      domremy = import ./hosts/domremy/domremy.nix;
      edinburgh = import ./hosts/edinburgh.nix;
      vps-jn-config = import ./hosts/vps-jn.nix;
      alamut = import ./hosts/alamut/alamut.nix;
      wales = import ./hosts/wales/wales.nix;
      gorgon = import ./hosts/gorgon/gorgon.nix;

      overlay = self: super: {
        arc-browser = nixpkgs-2505.legacyPackages.${self.system}.arc-browser;
      };
      nixpkgs-overlays =
        { pkgs, ... }:
        {
          nixpkgs.overlays = [ overlay ];
        };

    in
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#babylon
      darwinConfigurations."babylon" = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          babylon

          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
          }
        ];
      };

      darwinConfigurations."domremy" = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          domremy

          nixpkgs-overlays
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
          }
        ];
      };

      # Expose the package set, including overlays, for convenience.
      darwinPackages = self.darwinConfigurations."babylon".pkgs;

      nixosConfigurations."edinburgh" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          edinburgh

          dotfiles-private.nixosModules."edinburgh"

          nixpkgs-overlays
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
          }
        ];
      };

      darwinConfigurations."alamut" = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          dotfiles-private.darwinModules."alamut"
          alamut

          nixpkgs-overlays
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
          }
        ];
      };

      darwinConfigurations."wales" = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          wales

          nixpkgs-overlays
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
          }
        ];
      };

      darwinConfigurations."gorgon" = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          dotfiles-private.darwinModules."gorgon"
          gorgon

          nixpkgs-overlays
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
          }
        ];
      };

      nixosConfigurations."vps-jn" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          vps-jn-config
          dotfiles-private.nixosModules."vps-jn"

          nixpkgs-overlays
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
          }
        ];
      };

    };
}
