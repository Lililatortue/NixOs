{ self, inputs, ...}:
{
      flake.nixosModules.gamingConfiguration = { pkgs, lib, self',... }:
      {
            imports = [
                  self.nixosModules.gamingHardware 
                  self.nixosModules.user
                  self.nixosModules.desktop-gaming
                  #self.nixosModules.ssh
                  #self.nixosModules.persistance
            ];
            nix.settings.experimental-features = ["nix-command" "flakes"]; 
            # hardware specifique changes to make gaming experience better




            boot.loader.systemd-boot.enable = true;
            boot.loader.efi.canTouchEfiVariables = true;

            networking.hostName = "gaming";
            networking.networkmanager.enable = true;
            networking.firewall.enable = false;

            time.timeZone = "America/Montreal";
            fonts.packages = [ pkgs.nerd-fonts.jetbrains-mono ];

            services.openssh.enable = true;

            system.stateVersion = "25.11"; # Do not change this ffs
      };
}
