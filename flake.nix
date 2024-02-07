{
  description = "Example Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nixpkgs-unstable, home-manager }:

    let
      darwin-config = import ./platforms/darwin-common.nix;
      nixos-config = import ./platforms/nixos-common.nix;

      babylon-config = import ./platforms/darwin-common.nix;
      edinburgh-config = import ./hosts/edinburgh.nix;

    in
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#babylon
      darwinConfigurations."babylon" = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          darwin-config
          babylon-config
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
          nixos-config
          edinburgh-config
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
          }
        ];
      };

    };
}
