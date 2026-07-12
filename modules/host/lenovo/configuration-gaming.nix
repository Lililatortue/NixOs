{ self, inputs, ...}:
{
      flake.nixosModules.lenovoGamingConfiguration = { pkgs, lib, ... }:
      {
            imports = [
                  self.nixosModules.lenovoHardware 
                  self.nixosModules.user
                  self.nixosModules.bash
                  self.nixosModules.starship
                  # environment
                  self.nixosModules.desktop-gaming
            ];
            nix.settings.experimental-features = ["nix-command" "flakes"]; 

            hardware.bluetooth.enable = true; 
            hardware.bluetooth.powerOnBoot = true;
            hardware.graphics = {
                  enable = true;
                  enable32Bit = true;
                  extraPackages = [ 
                        pkgs.intel-media-driver 
                        pkgs.intel-ocl 
                        pkgs.intel-vaapi-driver 
                        pkgs.vulkan-loader
                        pkgs.vulkan-validation-layers
                  ];
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

            system.stateVersion = "25.11"; # Do not change this ffs
      };
}
