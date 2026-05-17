{
  description = "My Custom System Environment Flake";

  inputs = {
      nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
      flake-parts.url = "github:hercules-ci/flake-parts";
      import-tree.url = "github:vic/import-tree";
      wrapper-modules.url = "github:BirdeeHub/nix-wrapper-modules";
  };

 outputs = inputs: inputs.flake-parts.lib.mkFlake
      { inherit inputs; }
      {
        imports = [ (inputs.import-tree ./modules) ];

        flake.config.nixpkgs.config.allowUnfree = true; 
      };
}
