{self, inputs, ...}:
{ 
      flake.nixosModules.Llama = {...}:
      {
            programs.llama-cpp = {
                  enable = true;
            };

      };
}
