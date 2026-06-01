{self, inputs, ...}:
{
      
      flake.nixosModules.Llama = {pkgs, ...}:
      {
            programs.llama-cpp = {
                  enable = true;
                  package = pkgs.packages.myLlama.${pkgs.stdenv.hostPlatform.system}.myLlama;
            };

      };
      perSystem = {self', pkgs, ...}:
      {
            #wrap module
            packages.myLlama = inputs.wrapper-modules.lib.wrapPackages({config, wlib, lib, ...}: 
            {
                  inherit pkgs;  
                  flags = {
                        blas = true;
                  };
            }); 
      };
}
