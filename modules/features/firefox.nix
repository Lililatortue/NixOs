{ self, inputs, ... }:
{
      flake.nixosModules.firefox = {...}:
      {
            programs.firefox = {
                  enable = true;
           };
      };

}
