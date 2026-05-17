{ self, inputs, ... }: 
{
      perSystem = { system, ... }: {
            _module.args.pkgs = import inputs.nixpkgs {
                  inherit system;
                  config.allowUnfree = true; # <-- Unlocks unfree for flake-parts modules!
            };
      };
  flake.nixosConfigurations.myMachine = inputs.nixpkgs.lib.nixosSystem
  {
      specialArgs = { inherit self inputs; };
      modules = [
           self.nixosModules.myMachineConfiguration
           {
            nixpkgs.config.allowUnfree = true;
           }
      ];
  };
}
