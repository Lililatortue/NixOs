{inputs, self, ...}:
{
      
      perSystem= { pkgs, self, ...}:
      {
            packages.waybar-work = inputs.wrapper-modules.wrappers.waybar.wrap {
                  inherit pkgs;
                  configFile.path  = ./waybar/work/config.jsonc; 
                  "style.css".path = ./waybar/work/style.css;
            };

            packages.waybar-gaming= inputs.wrapper-modules.wrappers.waybar.wrap {
                  inherit pkgs;
                  configFile.path  = ./waybar/gaming/config.jsonc; 
                  "style.css".path = ./waybar/gaming/style.css;
            };
      };
}
