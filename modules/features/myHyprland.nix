{ self, inputs, ... }:
{
 
      flake.nixosModules.hyprland = {pkgs, lib, ...}: 
      {
            program.hyprland = {
                  enable  = true;
                  package = self.packages.${pkgs.stdenv.hostPlatform.system}.myHyprland;
            };
            
            xdg.configFile."hyprland/wallpaper.png".source = ./hyprland/wallpaper.png;
            xdg.configFile."hyprland/hyprland.conf".source = ./hyprland/hyprland.conf;
      };


      # my preconfig package hyprland config
      perSystem = {pkgs, lib, self', ...}: {
            packages.myHyprland = inputs.wrapper-modules.lib.wrapPackage({config, wlib, lib, ...}: {
                  inherit pkgs;

                  package = pkgs.hyprland;
                  extraPackages = with pkgs; [
                        # custom made packages
                        self'.packages.myWaybar
                        self'.packages.myKitty
                        self'.packages.myFirefox
                        self'.packages.mySlack
                        # premade stuff
                        obsidian
                        
                        wofi
                        hyprshot
                        mako
                        awww
                        wl-clipboard
                  ];
                  
                  flags = {
                        "--config" = pkgs.writeText "hyprland-wrapped.conf" (builtins.readFile ./hyprland/hyprland.conf);
                  };

            });
      };
}
