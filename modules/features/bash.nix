{self, inputs, ...}:
{
      flake.nixosModules.bash = {pkgs, lib, ...}:
      {
            programs.bash = {
                  enable = true;
                  shellAliases = {
                        work    = "cd ~/Documents/dev/job/";
                        project = "cd ~/Desktop/dev/";
                  };    
                  
            };
      };
}
