{ 
      self,
      inputs,
      ... 
}: {
      flake.wrapperModules.kitty = 
      {
            config,
            lib,
            ...
      }: {
            options.shell = lib.mkOption {
              type = lib.types.str;
              default = "";
            };
            config = {
            args = lib.mkAfter (lib.optionals (config.shell != "") [config.shell]);
            settings = {
                  font = {
                        name = "JetBrainsMono Nerd Font";
                        size = 15;
                  };                 
                  settings = {
                        dynamic_background_opacity = "yes";
                        background_opacity      ="0.85";                      
                        cursor_trail            = 3;
                        active_border_color     = "#00ff00";
                        inactive_border_color   = "#cccccc";
                        bell_border_color       = "#ff5a00";
                        wayland_titlebar_color  = "system";

                        active_tab_foreground   = "#000";
                        active_tab_background   = "#eee";
                        inactive_tab_foreground = "#444";
                        inactive_tab_background = "#999";

                        # Couleurs de base
                        foreground=            "#ebdbb2";
                        background=            "#272727";
                        selection_foreground=  "#655b53";
                        selection_background=  "#ebdbb2";
                        url_color=             "#d65c0d";
                        
                        # Palette ANSI (Normal et Brillant)
                        
                        # Black
                        color0=  "#272727";
                        color8=  "#928373";
                        
                        # Red
                        color1=  "#cc231c";
                        color9=  "#fb4833";
                        
                        # Green
                        color2=  "#989719";
                        color10= "#b8ba25";
                        
                        # Yellow
                        color3=  "#d79920";
                        color11= "#fabc2e";
                        
                        # Blue
                        color4=  "#448488";
                        color12= "#83a597";
                        
                        # Magenta
                        color5=  "#b16185";
                        color13= "#d3859a";
                        
                        # Cyan
                        color6=  "#689d69";
                        color14= "#8ec07b";
                        
                        # White
                        color7=  "#a89983";
                        color15= "#ebdbb2";
                  };
            };
            }; 
     }; 
}
