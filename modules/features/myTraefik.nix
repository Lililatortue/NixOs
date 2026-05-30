{ self, inputs, ...}:
{
      flake.nixosModules.traefik = {pkgs, ...}:
      {
            programs.traefik ={
                  enable = true;

                  package= self.packages.${pkgs.stdenv.hostPlatform.system}.myTraefik;
            };

      };

      perSystem = {...}:{
            packages.myTraefik = inputs.wrapper-modules.lib.wrapPackages({config, lib, pkgs, ...}:{
                  inherit pkgs;
                  
                  package = pkgs.traefik;
                  
                  dynamicConfigFile = builtins.json "./traefik/dynamic-config.json";

            });
      };
}
