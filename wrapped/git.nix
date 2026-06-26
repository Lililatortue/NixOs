{ inputs, ... }:
{
      perSystem= { pkgs, ... }:
      {
            packages.git = inputs.wrapper-modules.lib.wrapPackage {
                  inherit pkgs;
                  package = pkgs.git;
                  env = rec {
                        GIT_AUTHOR_NAME = "William Descoteaux";
                        GIT_AUTHOR_EMAIL = "will.descoteaux@gmail.com";
                        GIT_COMMITTER_NAME = GIT_AUTHOR_NAME;
                        GIT_COMMITTER_EMAIL = GIT_AUTHOR_EMAIL;
                  };
            };
      };
}
