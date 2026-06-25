{ inputs, self, ... }:
{
      flake.nixosModules.starship = {pkgs, ...}:
      {
            programs.starship = {
                  enable = true;
                  package = self.packages.${pkgs.stdenv.hostPlatform.system}.myStarship;
            };
      };
      perSystem = {pkgs, lib, self', ...}:
      {
            packages.myStarship = inputs.wrapper-modules.wrappers.starship.wrap {
                  inherit pkgs;

                  preset = [ "nerd-font-symbols" ];
                  
                  settings = {
                        format = "$directory$git_branch$git_status$fill$docker_context$gcloud$line_break$character";
                        character = {
                              success_symbol = "[❯](bold green)";
                              error_symbol = "[❯](bold red)";
                        };
                        fill = {
                              symbol = " ";
                        };
                        directory = {
                              style= "bold fg:yellow";
                              format="[$path ]($style)";
                              truncation_length=3;
                              truncation_symbol= ".../";
                              truncate_to_repo= false;
                        };
                        python = {
                              style = "teal";
                              format = "'((\$virtualenv))'";
                        };

                        git_branch = { };
                        git_status = { };
                        rust = { }; 

                        docker_context = {
                              format = "'[\$context](blue bold)'";
                        };
                        gcloud = {
                              format = "on [\$symbol\$account(@\$domain)(\(\$project\))](\$style)";
                        }; 
                  };
            };
      };
}
