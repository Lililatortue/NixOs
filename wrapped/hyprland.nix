{ 
      inputs,
      self,
      ... 
}: {      
      perSystem = 
      {
            pkgs,
            lib,
            system,
            self',
            ...
      }: {
            packages =
            lib.optionalAttrs( builtins.elem system pkgs.hyprland.meta.platforms ) {
            hyprland  = inputs.wrapper-modules.lib.wrapPackage({config, lib, ...}: {
                  options = {

                        bind     = lib.mkOption{
                              type = lib.types.attrsOf lib.types.str;
                              default = {};
                        };
                        exec-once= lib.mkOption{
                              type = lib.types.listOf lib.types.str;
                              default = [];
                        };
                  };
                  config =let
                        baseConfig= builtins.readFile (./. + "/hyprland/hyprland.conf");
                        bindLines = lib.mapAttrsToList (key: cmd: "bindl = ${key}, ${cmd}") config.bind;
                        execLines = map (cmd:"exec-once = ${cmd}") config.exec-once;

                        hyprlandConf = pkgs.writeText "hyprland-wrapped.conf" ''
                              # Core/Common System Configurations loaded first
                              ${baseConfig}
                              
                              # custom binds Overrides appended below
                              ${lib.concatStringsSep "\n" execLines}
                              ${lib.concatStringsSep "\n" bindLines}
                        '';
                  in{
                        inherit pkgs;
                        package = pkgs.hyprland; 
                        flags =
                       { "--config" = "${hyprlandConf}"; };
                  };
            });
            };
      };
}
