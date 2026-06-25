{ inputs, self, ... }:
{
      flake.nixosModules.desktop-gaming = {pkgs, ...}:
      let
            sp = self.packages."${pkgs.stdenv.hostPlatform.system}";
      in {
            imports = [
                  self.nixosModules.steam
                  self.nixosModules.firefox
                  self.nixosModules.ssh         # for servers
            ];
            environment.systemPackages = with pkgs; [
                  discord-ptb
            ];
 
            programs.hyprland.enable = true;
            programs.hyprland.package= sp.desktop-gaming;

            networking.hostName = "gaming";
            networking.networkmanager.enable = true;
            networking.firewall.enable = false;

      };
}
