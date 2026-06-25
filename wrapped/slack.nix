{ self, inputs, ...}:
{
      perSystem = {pkgs, lib, self', ...}:
      {
            packages.slack = inputs.wrapper-modules.lib.wrapPackage({config, wlib, lib, ...}: {
                  inherit pkgs;
                  package = pkgs.slack;
            });
      };
}
