{ inputs, self, ... }:
{
      flake.nixosModules.desktop-gaming = {pkgs, ...}:
      let
            sp = self.packages."${pkgs.stdenv.hostPlatform.system}";
      in {
            imports = [
                  self.nixosModules.steam
                  self.nixosModules.firefox
            #     self.nixosModules.ssh
            ];
            environment.systemPackages = with pkgs; [
                  discord-ptb
                  obsidian
            ];
 
            programs.hyprland.enable = true;
            programs.hyprland.package= sp.desktop-gaming;
            
            fonts.packages = with pkgs; [
                  nerd-fonts.jetbrains-mono
            ];

            time.timeZone = "America/Montreal";
            services.upower.enable = true;

            hardware = {
                  bluetooth.enable = true; 
                  bluetooth.powerOnBoot = true;
            };
      };
}
