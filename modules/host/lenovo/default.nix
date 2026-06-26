{ self, withSystem, inputs, ... }: 
{
      flake.nixosConfigurations.lenovo-work = withSystem "x86_64-linux" ({pkgs, self', ...}:
      inputs.nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            specialArgs = { inherit self inputs; };

            modules = [
                  ({pkgs, ...}: {
                        nixpkgs.config.allowUnfree = true;
                        imports = [self.nixosModules.lenovoWorkConfiguration]; 
                  })
            ];
      });

      flake.nixosConfigurations.lenovo-gaming = withSystem "x86_64-linux" ({pkgs, self', ...}:
      inputs.nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            specialArgs = { inherit self inputs; };

            modules = [
                  ({pkgs, ...}: {
                        nixpkgs.config.allowUnfree = true;
                        imports = [self.nixosModules.lenovoGamingConfiguration]; 
                  })
            ];
      });
}
