{ self, inputs, ...}:
{
      flake.nixosModules.user = {pkgs,...}:{
            users.users.lililatortue = {
                  isNormalUser = true;     
                  extraGroups = [ "docker" "wheel" "networkmanager" ];                   
                  initialPassword = "123";
            };
            users.groups.lililatortue = {};            
            virtualisation.docker.enable = true;
      };
}
