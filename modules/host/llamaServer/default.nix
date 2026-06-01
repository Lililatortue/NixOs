{ self, inputs, pkgs, ...}:
{
      flake.nixosConfigurations.llamaServer = inputs.nixpkgs.lib.nixosSystem
      {
            specialArgs = { inherit self inputs; };
            modules = [
                  self.darwinModules.llamaServer
            ];
            imports = 
                  if pkgs.stdenv.isDarwin then [
                        ./darwin/llamaServerConfiguration.nix.nix
                  ]  else [
                        ./linux/llamaServerConfiguration.nix
                  ];
      }; 
    

}
