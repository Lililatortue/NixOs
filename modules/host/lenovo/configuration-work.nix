{ self, inputs, ...}:
{
      flake.nixosModules.lenovoWorkConfiguration = { pkgs, lib, ... }:
      {
            imports = [
                  self.nixosModules.lenovoHardware 
                  self.nixosModules.user
                  self.nixosModules.bash
                  self.nixosModules.starship
                  self.nixosModules.direnv
                  self.nixosModules.nix-ld 
                  #environment
                  self.nixosModules.desktop-work 
            ];
            nix.settings.experimental-features = ["nix-command" "flakes"]; 

            # cronjob
            # ---------------
            programs.nh = {
                  enable = true;
                  clean = {
                        enable = true;
                        dates = "weekly";
                        extraArgs = "--keep-since 7d --keep 3";
                  };
            };

            hardware = {
                  bluetooth.enable = true; 
                  bluetooth.powerOnBoot = true;
            };
            
            system.stateVersion = "25.11"; # Do not change this ffs
      };
}
