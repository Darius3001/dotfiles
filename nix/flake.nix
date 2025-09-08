{
  description = "My NixOS + Home Manager flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }:
  let
    mkHost = hostname: system:
      nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/${hostname}/configuration.nix
          ./hosts/${hostname}/hardware-configuration.nix
          ./modules/test.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.darius = import ./home.nix;
          }
        ];
      };
  in {
    nixosConfigurations = {
      laptop  = mkHost "laptop" "x86_64-linux";
    };
  };
}
