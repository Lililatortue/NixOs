{ inputs, ... }:
{
      imports = [
            inputs.flake-parts.flakeModules.modules
      ]; 
      flake = {
            nixosConfigurations = {
                  myMachine = {
                        system  = "x86_64-linux";
                        modules = ["./host/myMachine/default.nix"]
                        ++ (inputs.import-tree ./features/all)
                        ++ (inputs.import-tree ./features/linux); #to allow hyprland
                  };
                  #llamaServer = {     
                  #      system  = "x86_64-linux"; 
                  #      modules = [
                  #            "./host/llamaServer/default.nix" 
                  #            inputs.agenix.nixosModules.default
                  #      ]
                  #      ++ (inputs.import-tree ./features/all)
                  #      ++ (inputs.import-tree ./features/linux);
                  #};
            };

            darwinConfigurations = {
                  llamaServer = {     
                        system  = "aarch64-darwin"; 
                        modules = [
                              "./host/llamaServer/default.nix"
                        ]
                        ++ (inputs.import-tree ./features/all)
                        ++ (inputs.import-tree ./features/darwin);
                  };
            };
      }; 
}
