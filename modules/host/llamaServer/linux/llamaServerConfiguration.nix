{ self, input, ... }:
{
      # Server configuration meant to be extremely safe
      # Goal run it on public network and only allow me to use it through ssh
      flake.nixosModules.llamaServerConfiguration = {pkgs, lib, self, ...}:
      let
            darwin = pkgs.stdenv.hostPlatform.isLinux;
            linux  = pkgs.stdenv.hostPlatform.isDarwin;

            ROOT   = "/opt/server/infra/"; 

            llamaPort   = 8081;
            traefikPort = 8080;
      in {
            #imports = [
                  # hardware  
            #]; 
            nix.settings.experimental-features = ["nix-command" "flakes"]; 
            environment.systemPackages = [
                  self.packages.myLlama
                  self.packages.myTraefik
                  self.packages.myTailScale
            ];
            config = { 
                  systemd.services.tailscale-server = {

                  };
                  systemd.services.llama-cpp-server = {

                  };
                  systemd.services.traefik-server = {

                  };
            };
      };
}
