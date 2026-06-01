{ self, inputs, ... }:
{

      flake.nixosModules.kitty = {pkgs, lib, ...}: 
      {                  
            programs.kitty = {
                  enable = true;
                  package= self.package.${pkgs.stdenv.hostPlatform.system}.myKitty;
            };

      };

      perSystem = {pkgs, lib, self', ...}: 
      {
            packages.myKitty =  inputs.wrapper-modules.wrappers.kitty.wrap {
                  inherit pkgs;

                  font = {
                        name = "JetBrainsMono Nerd Font";
                        size = 11;
                  };                 
                  themeFile = "ForestNight";
                  settings = {
                        cursor_trail            = 3;
                        active_border_color     = "#00ff00";
                        inactive_border_color   = "#cccccc";
                        bell_border_color       = "#ff5a00";
                        wayland_titlebar_color  = "system";

                        active_tab_foreground   = "#000";
                        active_tab_background   = "#eee";
                        inactive_tab_foreground = "#444";
                        inactive_tab_background = "#999";
                  };
            };
      };
      
}
