{ inputs, self, ... }:
{
      flake.nixosModules.desktop-work = {pkgs, ...}:
      let
            sp = self.packages."${pkgs.stdenv.hostPlatform.system}";
      in {            
            imports = [
                  self.nixosModules.firefox
            ];
            environment.systemPackages = [
                  sp.slack
		      sp.terminal-work
		      sp.environment-work
                  sp.waybar-work
                  pkgs.obsidian
            ];
            environment.pathsToLink = [ 
                  "/share/applications"
                  "/share/xdg-desktop-portal"
            ];
            
            programs.hyprland.enable = true;
            programs.hyprland.package=sp.desktop-work;	

            networking.hostName = "work";
            networking.networkmanager.enable = true;
            networking.firewall.enable = true;
            

            fonts.packages = [pkgs.nerd-fonts.jetbrains-mono];
            time.timeZone = "America/Montreal";

            boot.loader.systemd-boot.enable = true;
            boot.loader.efi.canTouchEfiVariables = true;

            services.upower.enable = true;
      };
}
