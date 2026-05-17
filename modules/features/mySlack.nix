
{ self, inputs, ...}:
{
      flake.nixosModules.slack = {pkgs, ...}:
      {     
            programs.slack = {
                  enable = true;
                  package = self.packages.${pkgs.stdenv.hostPlatform.system}.mySlack;
            };
      }; 

      perSystem = {pkgs, lib, self', ...}:
      {
            packages.mySlack = inputs.wrapper-modules.lib.wrapPackage({config, wlib, lib, ...}: {
                  inherit pkgs;
                  package = pkgs.slack;

            });
      };
}
