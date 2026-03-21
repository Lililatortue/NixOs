# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

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
      services.openssh.enable = true;

      networking.firewall.enable = true;

      system.stateVersion = "25.11"; # Did you read the comment?

}

