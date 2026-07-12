{ self, inputs, ...}:
{
      flake.nixosModules.lenovoWorkConfiguration = { stable, pkgs, lib, ... }:
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

            environment.systemPackages = [
                inputs.agenix.packages.${pkgs.stdenv.hostPlatform.system}.default
            ];
            age.secrets.git-secret = {
                file = ./secrets/git.age;
                owner= "lililatortue";
                group= "users";
                mode = "0400";
            };

            services.openssh = {
                enable = true;
                settings.PermitRootLogin = "no"; 
            };

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
