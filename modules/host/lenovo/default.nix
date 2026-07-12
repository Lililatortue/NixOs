{ self, withSystem, inputs, ... }: 
{
      flake.nixosConfigurations.lenovo-work = withSystem "x86_64-linux" ({stable, ...}:
      inputs.nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            specialArgs = { inherit self inputs stable; };

            modules = [
                inputs.agenix.nixosModules.default
                ({...}: {
                    nixpkgs.config.allowUnfree = true;
                    imports = [self.nixosModules.lenovoWorkConfiguration]; 
                })
            ];
      });

      flake.nixosConfigurations.lenovo-gaming = withSystem "x86_64-linux" ({stable, ...}:
      inputs.nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            specialArgs = { inherit self inputs stable; };

            modules = [
                  ({...}: {
                        nixpkgs.config.allowUnfree = true;
                        imports = [self.nixosModules.lenovoGamingConfiguration]; 
                  })
            ];
      });
}
