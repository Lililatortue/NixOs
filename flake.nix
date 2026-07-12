{
      description = "My Custom System Environment Flake";
      inputs = {
            nixpkgs.url   = "github:nixos/nixpkgs/nixos-unstable";
            nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-26.05"; 
            

            flake-parts.url = "github:hercules-ci/flake-parts";
            import-tree.url = "github:vic/import-tree";
            wrapper-modules.url = "github:BirdeeHub/nix-wrapper-modules";          

            agenix.url = "github:ryantm/agenix";


            nix-darwin.url = "github:nix-darwin/nix-darwin";
            nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
      };
      
      outputs = inputs: inputs.flake-parts.lib.mkFlake
          { inherit inputs; }
          {
                imports = [ 
                      (inputs.import-tree ./modules) 
                      (inputs.import-tree ./wrapped) 
                ];
          };
}
