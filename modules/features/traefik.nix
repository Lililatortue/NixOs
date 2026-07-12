{ self, inputs, ...}:
{
      flake.nixosModules.traefik = {...}:
      {
            programs.traefik ={
                  enable = true;
            };

      };

}
