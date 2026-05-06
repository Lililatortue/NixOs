

{ config, pkgs, inputs, ... }:

{
      imports = [ 	
	      ./hardware-configuration.nix
      ];
      environment.pathsToLink = [ 
            "/share/applications"
            "/share/xdg-desktop-portal"
      ];
      users.users.lililatortue = {
            isNormalUser = true;     
            extraGroups = [ "wheel" "networkmanager" ]; 
      };
      users.groups.lililatortue = {};

	nixpkgs.config.allowUnfree = true;
	nix.settings.experimental-features = ["nix-command" "flakes"];

      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;

      networking.networkmanager.enable = true;

      time.timeZone = "America/Montreal";


      fonts.packages = [ pkgs.nerd-fonts.jetbrains-mono ];
      # List packages installed in system profile.
      environment.systemPackages = with pkgs; [
     	      vim 
     	      wget
     	      git
            v4l-utils
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
      programs.direnv = {
            enable = true;
            nix-direnv.enable = true;
            silent = true;
      };
	xdg.portal = {
		enable=true;
		extraPortals =  [pkgs.xdg-desktop-portal-hyprland];
	};

      # enable clamshell mode 
      services.logind.lidSwitchExternalPower = "ignore";


      services.openssh.enable = true;
	services.upower.enable = true;
      
      networking.firewall.enable = true;

      system.stateVersion = "25.11"; # Did you read the comment?

}

