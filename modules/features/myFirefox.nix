{ self, inputs, ... }:
{
      flake.nixosModules.firefox = {pkgs, lib, ...}:
      {
            programs.firefox = {
                  enable = true;
                  packages = self.packages.${pkgs.stdenv.hostPlatform.system}.myFirefox;
           };
      };



      perSystem = {pkgs, lib, self', ...}: 
      {
            packages.myFirefox = inputs.wrapper-modules.lib.wrapPackage({config, wlib, lib, ...}: {
                  inherit pkgs;
                  package = pkgs.firefox;

                  flags = {
                  "--profile" = pkgs.runCommand "firefox-profile" {} ''
                  mkdir -p $out
                        cat <<EOF > $out/user.js
                        user_pref("browser.startup.homepage", "https://wiki.nixos.org/wiki/");
                        user_pref("browser.theme.content-theme", 0);
                        user_pref("browser.theme.toolbar-theme", 0);
                        user_pref("ui.systemUsesDarkTheme", 1);
                        user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true); 
                        user_pref("devtools.inspector.showUserAgentStyles", true);
                  EOF'';
                  };
            });
      };
}
