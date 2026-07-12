{ withSystem, inputs, self, ...}:
{
      flake.packages.x86_64-linux = 
      withSystem "x86_64-linux" ({pkgs, self', ...}:
      let 
            sharedPackages = [
                  pkgs.hyprshot
                  pkgs.mako
                  pkgs.wofi
                  pkgs.awww
                  pkgs.wl-clipboard
            ];

      in {
            
      desktop-gaming = self'.packages.hyprland.wrap {                  
            extraPackages = sharedPackages;
            bind = {
                  "ALT, i" = "exec, hyprctl dispatch workspace 1 && (hyprctl clients | grep -i steam && hyprctl dispatch focuswindow steam || steam)";
                  "ALT, f" = "exec, hyprctl dispatch workspace 2 && (hyprctl clients | grep -i firefox && hyprctl dispatch focuswindow firefox || firefox)";
                  "ALT, d" = "exec, hyprctl dispatch workspace 3";
                  "ALT, w" = "exec, pidof waybar && pkill -USR1 waybar || waybar";
                  "ALT, P" = "exec, $sshot --notify -m window -m active --clipboard-only";
                  "ALT SHIFT,P" = "exec, $sshot --notify -m output -m active --clipboard-only";
            };
            exec-once= ["steam" "mako" "awww-daemon && sleep 0.5" "awww img $wallpaper"];
      };

      desktop-work = self'.packages.hyprland.wrap {                  
            extraPackages = sharedPackages;
            bind = {                        
                  "ALT, Q" = " exec, kitty";
                  "ALT, B" = " exec, firefox";
                  "ALT, Z" = " exec, slack";
                  "ALT, X" = " exec, libreoffice";
                  "ALT, C" = " killactive";
                  "ALT, O" = " exec, obsidian";
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
                  "ALT SHIFT,P" = "exec, $sshot --notify -m output -m active --clipboard-only";
                  "ALT CTRL, P" = "exec, $sshot -m region -o $HOME/Downloads";

            };
            exec-once= ["hypridle" "waybar" "mako" "awww-daemon && sleep 0.5" "awww img $wallpaper"];
      };
      });
}
