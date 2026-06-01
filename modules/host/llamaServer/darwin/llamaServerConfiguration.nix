{ self, input, ... }:
{
      # Server configuration meant to be extremely safe
      # Goal run it on public network and only allow me to use it through ssh
      flake.nixosModules.llamaServerConfiguration = {pkgs, lib, self, ...}:
      let
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
                  self.packages.myAgenix
            ];
            config = {
                  # enable tailscale
                  launchd.user.agents.tailscale-server = {
                        command = "tailscale";
                  };

                  # enable llama
                  launchd.user.agents.llama-cpp-server = {
                        command = "llama";
                        servicesConfig = {      
                              keepAlive = true;
                              RunAtLoad = true;
                        }; 
                  };

                  # enable traefik
                  launchd.user.agents.traefik-server = {
                        command = "traefik";
                        serviceConfig = {
                              workingDirectory = ROOT; 
                              ProgramArguments= ["docker" "compose" "up"];

                              keepAlive = true;
                              RunAtLoad = true;
                        };
                  };
            };
      };
}
