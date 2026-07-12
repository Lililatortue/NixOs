{ inputs, self, ... }:
{
      flake.nixosModules.desktop-gaming = {stable, pkgs, ...}:
      let
            sp = self.packages."${pkgs.stdenv.hostPlatform.system}";
      in {
            imports = [
                  self.nixosModules.steam
                  self.nixosModules.firefox
                  
            #      self.nixosModules.ssh         # for servers
            ];
            environment.systemPackages =  [
		      sp.terminal-gaming
		      sp.environment-work
                  sp.waybar-work
 
                  stable.discord-ptb
                  pkgs.vim
            ]; 
            environment.pathsToLink = [ 
                  "/share/applications"
                  "/share/xdg-desktop-portal"
            ];

            programs.hyprland.enable = true;
            programs.hyprland.package= sp.desktop-gaming;

            networking.hostName = "gaming";
            networking.networkmanager.enable = true;
            networking.firewall.enable = false;

            fonts.packages = [stable.nerd-fonts.jetbrains-mono];
            time.timeZone = "America/Montreal";

            boot.loader.systemd-boot.enable = true;
            boot.loader.efi.canTouchEfiVariables = true;

            services.upower.enable = true;
      };
}
