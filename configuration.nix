# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports = [ 	
	<home-manager/nixos>
	./hardware-configuration.nix
      ];
	nix.settings.experimental-features = ["nix-command" "flakes"];

      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;

      networking.networkmanager.enable = true;

      time.timeZone = "America/Montreal";
      home-manager.users.lililatortue = import ./modules/home/home.nix; 

  users.users.lililatortue = {
     isNormalUser = true;
     extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
     packages= with pkgs; [
	firefox
     ];
  };


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

  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = true;

  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  system.copySystemConfiguration = true;


  system.stateVersion = "25.11"; # Did you read the comment?

}

