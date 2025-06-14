{
  description = "Example Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/25.05-pre";
    nixpkgs-darwin.url = "github:NixOS/nixpkgs/nixpkgs-25.05-darwin";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin/nix-darwin-25.05";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs-darwin";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    dotfiles-private = {
      url = "git+ssh://git@github.com/kino-ma/dotfiles-private?ref=main";
    };

  };

  outputs =
    inputs@{
      self,
      nix-darwin,
      nixpkgs,
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
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
          }
        ];
      };

    };
}
