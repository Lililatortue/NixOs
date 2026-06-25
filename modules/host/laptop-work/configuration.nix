{ self, inputs, ...}:
{
      flake.nixosModules.laptopConfiguration = { pkgs, lib, ... }:
      let
            sp = self.packages.${pkgs.stdenv.hostPlatform.system};
      in {
            imports = [
                  self.nixosModules.laptopHardware 
                  self.nixosModules.starship
                  self.nixosModules.direnv
                  self.nixosModules.bash
                  self.nixosModules.desktop-work
                  self.nixosModules.user
            #     self.nixosModules.git
            ];

            nix.settings.experimental-features = ["nix-command" "flakes"];
            environment.pathsToLink = [ 
                  "/share/applications"
                  "/share/xdg-desktop-portal"
            ];

            environment.systemPackages = with pkgs; [
     	            vim 
     	            git
            ];

            boot.loader.systemd-boot.enable = true;
            boot.loader.efi.canTouchEfiVariables = true;
  
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
 
            system.stateVersion = "25.11"; # Do not change this ffs
      };
}
