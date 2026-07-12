{ self, inputs, ...}:
{
      flake.nixosModules.direnv = {...}:
      {
            programs.direnv = {
                  enable = true;
                  silent = true;
                  nix-direnv.enable = true;
                  settings.global = {
                        hide_env_diff = true;
                  };

            };
      };

}
