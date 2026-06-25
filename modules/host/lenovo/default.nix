{ self, withSystem, inputs, ... }: 
{
      flake.nixosConfigurations.lenovo = withSystem "x86_64-linux" ({pkgs, self', ...}:
      inputs.nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            specialArgs = { inherit self inputs; };

            modules = [
                  self.nixosModules.lenovoConfiguration
            ];
      });
}
