{ self, inputs, ...}:
{
      flake.nixosModules.lenovoConfiguration = { pkgs, lib, ... }:
      let
            sp = self.packages.${pkgs.stdenv.hostPlatform.system};
      in {
            imports = [
                  self.nixosModules.lenovoHardware 
                  self.nixosModules.user
                  self.nixosModules.bash
                  self.nixosModules.starship
            #     self.nixosModules.git
            ];

            environment.systemPackages = with pkgs; [
     	            vim 
     	            git
            ];
            nix.settings.experimental-features = ["nix-command" "flakes"]; 

            environment.pathsToLink = [ 
                  "/share/applications"
                  "/share/xdg-desktop-portal"
            ];
            fonts.packages = [pkgs.nerd-fonts.jetbrains-mono];
            time.timeZone = "America/Montreal";
            boot.loader.systemd-boot.enable = true;
            boot.loader.efi.canTouchEfiVariables = true;

            services.upower.enable = true;
            hardware = {
                  bluetooth.enable = true; 
                  bluetooth.powerOnBoot = true;

            };

            specialisation = {
                  work.configuration = { 
                        imports = [
                              self.nixosModules.desktop-work
                              self.nixosModules.direnv
                        #     self.nixosModules.nix-ld
                        ]; 
                        
 
                        programs.nix-ld.enable  = true;
                        programs.nix-ld.libraries = with pkgs; [
    	                        stdenv.cc.cc
    	                        zlib
    	                        fuse3
    	                        icu
    	                        nss
    	                        openssl
    	                        curl
    	                        expat		
                        ];
	                  # enable clamshell mode 
                        services.logind.settings.Login.HandleLidSwitchExternalPower = "ignore";
                  
                  }; 
                  gaming.configuration = {
                        imports = [
                              self.nixosModules.desktop-gaming
                              #self.nixosModules.ssh
                              #self.nixosModules.persistance
                        ];

                        services.openssh.enable = true;
                        hardware = {
                              graphics = {
                                    enable = true;
                                    enable32Bit = true;
                                    extraPackages = with pkgs; [ 
                                          intel-media-driver 
                                          intel-ocl 
                                          intel-vaapi-driver 
                                          vulkan-loader
                                          vulkan-validation-layers
                                    ];
                              };
                        };

                  };
            };
            system.stateVersion = "25.11"; # Do not change this ffs
      };
}
