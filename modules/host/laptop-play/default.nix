{ self, withSystem, inputs, ... }: 
{
      flake.nixosConfigurations.gaming = withSystem "x86_64-linux" ({pkgs, self', ...}:
      inputs.nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            specialArgs = { inherit self inputs; };

            specialisation = {
            modules = [
                  self.nixosModules.gamingConfiguration 
            ]; 
            };
            gaming.specialisation = {
            modules = [
                  self.nixosModules.gamingConfiguration 
            ];
            };
      });
}
