{
      description = "My NixOs setup";

      inputs = {
            nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

            home-manager = {
                  url = "github:nix-community/home-manager";
                  inputs.nixpkgs.follows = "nixpkgs";
            };
            nixvim = {
                  url = "github:nix-community/nixvim";
                  inputs.nixpkgs.follows = "nixpkgs";
            };
      };

      outputs= { self, nixpkgs, home-manager, ... }@inputs:
            let
                  system = "x86_64-linux";
                  pkgs = nixpkgs.legacyPackages.${system};
            in {
                  nixosConifguration.nixos = nixpkgs.lib.nixosSystem{
                  specialArgs = {inherit inputs;};
                  modules = [
                        ./configuration.nix
                        home-manager.nixosModules.home-manager {
                              home-manager.useGlobalPkgs = true;
                              home-manager.useUserPackages = true;
                              home-manager.users.lililatortue = import ./modules/home/home.nix; 
                              home-manager.extraSpecialArgs = { inherit inputs; };
                        }
                  ];
                  };
            };
}
