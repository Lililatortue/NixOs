{ withSystem, inputs, self, ...}:
{
      flake.packages.x86_64-linux = 
      withSystem "x86_64-linux" ({pkgs, self', ...}:{
      desktop-gaming = self'.packages.hyprland.wrap {                  
            bind = {
                  "mouse:276, a" = "exec, hyprctl dispatch workspace 1 && (hyprctl clients | grep -i steam && hyprctl dispatch focuswindow steam || steam)";
                  "mouse:276, s" = "exec, hyprctl dispatch workspace 2 && (hyprctl clients | grep -i firefox && hyprctl dispatch focuswindow firefox || firefox)";
                  "mouse:276, d" = "exec, hyprctl dispatch workspace 3";
                  "mouse:276, f" = "exec, pidof waybar && pkill -USR1 waybar || waybar";
            };
            exec-once= ["steam" "mako" "awww-daemon && sleep 0.5" "awww img $wallpaper"];
      };

      desktop-work = self'.packages.hyprland.wrap {                  
            extraPackages = [
                  pkgs.hyprshot
                  pkgs.slack
                  pkgs.libreoffice
                  pkgs.obsidian
            ];
            bind = {                        
                  "ALT, Q" = " exec, $terminal";
                  "ALT, B" = " exec, $browser";
                  "ALT, Z" = " exec, $slack";
                  "ALT, X" = " exec, $office";
                  "ALT, C" = " killactive";
                  "ALT, O" = " exec, $notes";
                  "ALT, M" = " exit";
                  "ALT, R" = " exec, $menu";
                  "ALT, v" = " pseudo,";
                  
                  "ALT, h" = "movefocus, l";
                  "ALT, l" = "movefocus, r";
                  "ALT, k" = "movefocus, u";
                  "ALT, j" = "movefocus, d";
                  
                  "ALT, a" = "workspace, 1";
                  "ALT, s" = "workspace, 2";
                  "ALT, d" = "workspace, 3";
                  "ALT, f" = "workspace, 4";
                  "ALT, g" = "workspace, 5";
                  "ALT, P" = "exec, $sshot --notify -m window -m active --clipboard-only";
                  "ALT,SHIFT,P"= "exec, $sshot --notify -m output -m active --clipboard-only";
                  "ALT,CTRL, P"= "exec, $sshot -m region -o $HOME/Downloads";

            };
            exec-once= ["hypridle" "waybar" "mako" "awww-daemon && sleep 0.5" "awww img $wallpaper"];
      };
      });
}
