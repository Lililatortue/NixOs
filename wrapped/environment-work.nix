{
      lib,
      inputs,
      self,
      ...
}: {
      perSystem = {
            pkgs,
            system,
            self',
            ...
      }: { 
            packages.terminal-work = inputs.wrapper-modules.wrappers.kitty.wrap {
                  inherit pkgs;

                  font = {
                        name = "JetBrainsMono Nerd Font";
                        size = 11;
                  };                 
                  settings = {
                        args = pkgs.lib.getExe self'.packages.environment-work;
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

                        foreground=            "#ebdbb2";
                        background=            "#272727";
                        selection_foreground=  "#655b53";
                        selection_background=  "#ebdbb2";
                        url_color=             "#d65c0d";
                        color0=  "#272727";
                        color8=  "#928373";
                        color1=  "#cc231c";
                        color9=  "#fb4833";
                        color2=  "#989719";
                        color10= "#b8ba25";
                        color3=  "#d79920";
                        color11= "#fabc2e";
                        color4=  "#448488";
                        color12= "#83a597";
                        color5=  "#b16185";
                        color13= "#d3859a";
                        color6=  "#689d69";
                        color14= "#8ec07b";       
                        color7=  "#a89983";
                        color15= "#ebdbb2";
                  };
            };

            packages.environment-work = inputs.wrapper-modules.lib.wrapPackage {
                  inherit pkgs;
                  package = pkgs.bash;
                  extraPackages = [
                        pkgs.nil
                        pkgs.nixd
                        pkgs.statix
                        pkgs.alejandra
                        pkgs.manix
                        pkgs.nix-inspect
                        
                        pkgs.unzip
                        pkgs.zip
                        pkgs.sshfs
                        pkgs.ripgrep
                        pkgs.wget
                        pkgs.htop 
                        pkgs.tree-sitter
                        self'.packages.neovimFull
                        self'.packages.git
                  ];

            };
      };
}
