{ self, input, ... }:
{
      # Server configuration meant to be extremely safe and slim
      # Goal run it on public network and only allow me to use it through ssh
      #flake.darwinModules.macmini-config = {pkgs, lib, self, ...}:
      #{ 
      #      imports = [
      #            self.darwinModules.macmini-hardware
      #            self.nixosModules.users
      #      ];
      #      # personnal config of mac-mini
      #      nix.settings.experimental-features = ["nix-command" "flakes"]; 

      #};
}
