{ self, inputs, ...}:
{
      flake.nixosModules.direnv = {pkgs, lib, ...}:
      {
            programs.direnv = {
                  enable = true;
                  silent = true;
                  nix-direnv.enable = true;
                  settings.global = {
                        hide_env_diff = true;
                  };

                  package = self.packages.${pkgs.stdenv.hostPlatform.system}.myDirenv;
            };
      };
      perSystem = {pkgs, lib, self', ...}:
      {
            packages.myDirenv = inputs.wrapper-modules.lib.wrapPackage({config, wlib, lib, ...}: {
                  inherit pkgs;
                  package = pkgs.direnv;
            });
      };
}
