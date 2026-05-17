{ self, inputs, ...}:
{
      flake.nixosModules.myMachineConfiguration = {pkgs, lib, ... }:
      {
            imports = [
                  self.nixosModules.myMachineHardware
                  self.nixosModules.direnv
#                  self.packages.myNeovimSudo
            ];

            nix.settings.experimental-features = ["nix-command" "flakes"];
            environment.pathsToLink = [ 
                  "/share/applications"
                  "/share/xdg-desktop-portal"
            ];

            ################
            #     users    #
            ################
            users.users.lililatortue = {
                  isNormalUser = true;     
                  extraGroups = [ "docker" "wheel" "networkmanager" ]; 
                  
                  initialPassword = "123";
                  packages = with pkgs; [
                        git 
                        zathura
                        docker
                        self.packages.${pkgs.stdenv.hostPlatform.system}.myHyprland
                        self.packages.${pkgs.stdenv.hostPlatform.system}.neovimFull
                  ];

            };
            users.groups.lililatortue = {};
            

            boot.loader.systemd-boot.enable = true;
            boot.loader.efi.canTouchEfiVariables = true;

            networking.hostName = "myMachine";
            networking.networkmanager.enable = true;
            networking.firewall.enable = true;

            time.timeZone = "America/Montreal";


            fonts.packages = [ pkgs.nerd-fonts.jetbrains-mono ];
            # List packages installed in system profile.
            environment.systemPackages = with pkgs; [
     	            vim 
     	            git
                  self.packages.${pkgs.stdenv.hostPlatform.system}.neovimSudo
                  self.packages.${pkgs.stdenv.hostPlatform.system}.myFirefox
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
	

      programs.hyprland.enable = true;
      xdg.portal = {
		enable=true;
		extraPortals =  [pkgs.xdg-desktop-portal-hyprland];
	};

      # enable clamshell mode 
      services.logind.settings.Login.HandleLidSwitchExternalPower = "ignore";


      services.openssh.enable = true;
	services.upower.enable = true;
      

      system.stateVersion = "25.11"; # Do not change this ffs
      };
}
