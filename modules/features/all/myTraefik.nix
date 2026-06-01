{ self, inputs, ...}:
{
      flake.nixosModules.traefik = {pkgs, ...}:
      {
            programs.traefik ={
                  enable = true;
                  package= self.packages.${pkgs.stdenv.hostPlatform.system}.myTraefik;
            };

      };

      perSystem = {pkgs, self', ...}:{
            packages.myTraefik = inputs.wrapper-modules.lib.wrapPackage({config,wlib, lib, ...}: {
                  inherit pkgs;
                  package = pkgs.traefik;

                  flags = {
                        "--configfile" = pkgs.writeText "traefik-config.yml" (builtins.readFile ./traefik/traefik-config.yml);
                  };
            });
      };
}
