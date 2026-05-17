{ self, inputs, ... }: 
{
  flake.nixosConfigurations.myMachine = inputs.nixpkgs.lib.nixosSystem
  {
      specialArgs={ inherit self inputs; };
      modules = [
            {
                  nixpkgs.config.allowUnfree = true;
            } 
            self.nixosModules.myMachineConfiguration
    ];
  };
}
