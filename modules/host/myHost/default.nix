{ self, inputs, ... }: 
{
  flake.nixosConfigurations.myMachine = inputs.nixpkgs.lib.nixosSystem
  {
      specialArgs = { inherit self inputs; };
      modules = [
      {
        nixpkgs.pkgs = import inputs.nixpkgs {
          system = "x86_64-linux";
          config.allowUnfree = true;
        };
      }
            self.nixosModules.myMachineConfiguration
    ];
  };
}
