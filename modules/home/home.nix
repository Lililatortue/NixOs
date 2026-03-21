{ config, pkgs, inputs, lib,  ... }:
{
      imports = [
            ./nvim           
      ];
	home.username      = "lililatortue";
	home.homeDirectory = lib.mkForce "/home/lililatortue";
	#			#
	#	filesystem	#
	#			#




	#			#
	#	Programs	#
	#			#
	home.packages = with pkgs; [ 
		# hyprland tooling	
		hyprland
		kitty
		hyprshot
		jq
		mako
		swww
		wl-clipboard
		waybar
		# ide tooling
		ripgrep
		# browser
		firefox
	];
	
	#			#
	#	hyprland	#
	#			#
	wayland.windowManager.hyprland = {
		enable = true;
		settings = {
			"$wallpaper" = "~/.config/hypr/wallpaper.png";
			monitor= ",preferred,auto,auto";
			"$terminal"= "kitty";
			"$browser" = "firefox";
			"$menu"    = "wofi --show drun";
			"$mainMod" = "ALT";
			bind = [
				"$mainMod, Q, exec, kitty"
				"$mainMod, B, exec, $browser"
				"$mainMod, z, exec, teams-for-linux"
				"$mainMod, C, killactive"
				"$mainMod, M, exit"
				"$mainMod, E, exec, $fileManager"
				"$mainMod, V, togglefloating"
				"$mainMod, R, exec, $menu"
				"$mainMod, v, pseudo," # dwindle
				"$mainMod, n, togglesplit," # dwindle
				
				# alt + vim keybinds to navigate
				"$mainMod, h, movefocus, l"
				"$mainMod, l, movefocus, r"
				"$mainMod, k,  movefocus,u"
				"$mainMod, j, movefocus, d"

				# Switch workspaces
				"$mainMod, a, workspace, 1"
				"$mainMod, s, workspace, 2"
				"$mainMod, d, workspace, 3"
				"$mainMod, f, workspace, 4"
				"$mainMod, g, workspace, 5"
				"$mainMod, 6, workspace, 6"
				"$mainMod, 7, workspace, 7"
				"$mainMod, 8, workspace, 8"
				"$mainMod, 9, workspace, 9"
				"$mainMod, 0, workspace, 10"
				"$mainMod, P, exec, hyprshot --notify -m window -m active --clipboard-only" 
				"$mainMod SHIFT, P, exec, hyprshot --notify -m output -m active --clipboard-only"
				" ,Print, exec, hyprshot --notify -m region"


			];
			general = {
				gaps_in     = 5;
				gaps_out    = 20;
				border_size = 1;
   				"col.active_border"   = "rgba(e2e8e9ee) rgba(708090ee) 45deg";
    				"col.inactive_border" = "rgba(595959aa)";
				layout = "dwindle";
				resize_on_border = false;
			};
			input = {
				kb_layout= "us";
				follow_mouse = 1;
				touchpad = {
					natural_scroll = false;
				};
			};
			decoration = {
				rounding = 2;
				active_opacity = 1.0;
				inactive_opacity = 1.0;
			
			};
                  animations = {
                        enabled = true;

                        bezier = [
                              "easeOutQuint, 0.23, 1, 0.32, 1"
                              "easeInOutCubic, 0.65, 0.05, 0.36, 1"
                              "linear, 0, 0, 1, 1"
                              "almostLinear, 0.5, 0.5, 0.75, 1"
                              "quick, 0.15, 0, 0.1, 1"
                        ];
                        animation = [
                              "global, 1, 10, default"
                              "border, 1, 5.39, easeOutQuint"
                              "windows, 1, 4.79, easeOutQuint"
                              "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
                              "windowsOut, 1, 1.49, linear, popin 87%"
                              "fadeIn, 1, 1.73, almostLinear"
                              "fadeOut, 1, 1.46, almostLinear"
                              "fade, 1, 3.03, quick"
                              "layers, 1, 3.81, easeOutQuint"
                              "layersIn, 1, 4, easeOutQuint, fade"
                              "layersOut, 1, 1.5, linear, fade"
                              "fadeLayersIn, 1, 1.79, almostLinear"
                              "fadeLayersOut, 1, 1.39, almostLinear"
                              "workspaces, 1, 1.94, almostLinear, fade"
                              "workspacesIn, 1, 1.21, almostLinear, fade"
                              "workspacesOut, 1, 1.94, almostLinear, fade"
                              "zoomFactor, 1, 7, quick"
                        ];
                  };
			dwindle = {
				pseudotile = true;
				preserve_split = true;
			};
			"exec-once" = [
				"waybar"
				"mako"
				"swww-daemon"
				"swww img $wallpaper"
			];
		};


	};
      xdg.configFile."hypr/wallpaper.png".source = ./hyprland/wallpaper.png;
	#			#
	#	waybar	#
	#			#
	programs.waybar.enable = true;
	xdg.configFile."waybar/config".source = ./waybar/config.jsonc; 
      xdg.configFile."waybar/style.css".source    = ./waybar/style.css;
      
      #                 #
      #     kitty       #
      #                 #
      programs.kitty = {
            enable = true;
            font = {
                  name = "JetBrainsMono Nerd Font";
                  size = 11;
            };
            extraConfig = ''
                  bold_font        auto
                  italic_font      auto
                  bold_italic_font auto
		  include current-theme.conf
            '';
      };
      xdg.configFile."kitty/current-theme.conf".source = ./kitty/current-theme.conf;
      #                 #
      #     bash        #
      #                 #
      programs.bash = {
            enable = true;
            enableCompletion = true;
      };
      
      
      #                 #
      #     firefox     #
      #                 #
      programs.firefox = {
            enable = true;
            profiles.default = {
                  settings = {
                        "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org"; 
                        "layout.css.prefers-color-scheme.content-override" = 0; 
                        "browser.display.os-colors.active" = true;
                        "browser.display.use_system_colors" = true;
                        "browser.display.background_color" = "#111111";
                        "browser.display.foreground_color" = "#eeeeee";
                        "ui.systemUsesDarkTheme" = 1; 
                        "browser.theme.content-theme" = 0;
                        "browser.theme.toolbar-theme" = 0;
                  }; 
            };
      };

	home.stateVersion = "24.11";
	programs.home-manager.enable = true;
}
