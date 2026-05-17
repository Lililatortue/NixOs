{ self, inputs, ... }:
{
      perSystem = {pkgs, ...}: 
      {
            packages.myWaybar = inputs.wrapper-modules.wrappers.waybar.wrap {
                  inherit pkgs;
                  configFile.path  = ./waybar/config.jsonc; 
                  "style.css".path = ./waybar/style.css;
            };
      };
}

