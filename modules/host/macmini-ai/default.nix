{ withSystem, self, inputs, ...}:
{
      #flake.darwinConfigurations.macMini = withSystem "aarch64-darwin" ({config, pkgs, inputs', ...}: 
      #inputs.nix-darwin.lib.darwinSystem
      #{
      #      specialArgs = { inherit self inputs; };
      #      modules = [
      #            inputs.darwinModules.macmini-config
      #            { nixpkgs.config.allowUnfree = true; }
      #      ];
      #     
      #  
      #}); 
}
