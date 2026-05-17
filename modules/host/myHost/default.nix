{ self, inputs, ... }: 
{
  flake.nixosConfigurations.myMachine = inputs.nixpkgs.lib.nixosSystem
  {
      specialArgs={ inherit self inputs; };
      modules = [
      self.nixosModules.myMachineConfiguration
     ];
  };
}
