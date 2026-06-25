{ inputs, self, ... }:
{
      flake.nixosModules.desktop-work = {pkgs, ...}:
      let
            sp = self.packages."${pkgs.stdenv.hostPlatform.system}";
      in {            
            imports = [
                  self.nixosModules.firefox
            #      self.nixosModules.persistance

            ];
            environment.systemPackages = [
                  sp.slack
		      sp.terminal-work
		      sp.environment-work
                  sp.waybar-work
                  pkgs.obsidian
            #---- futur plans ----
            #     sp.direnv
            #     sp.obsidian
            ];
            
            programs.hyprland.enable = true;
            programs.hyprland.package=sp.desktop-work;
            
            fonts.packages = [pkgs.nerd-fonts.jetbrains-mono];
	
            time.timeZone = "America/Montreal";
            networking.hostName = "work";
            networking.networkmanager.enable = true;
            networking.firewall.enable = true;

            services.openssh.enable = true; 
            services.upower.enable = true;
      };
}
