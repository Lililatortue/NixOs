{ self, inputs, ... }:
{
      flake.nixosModules.nix-ld = {pkgs, lib, ...}:
      {             
            programs.nix-ld.enable  = true;
            programs.nix-ld.libraries = [
    	            pkgs.stdenv.cc.cc
    	            pkgs.zlib
    	            pkgs.fuse3
    	            pkgs.icu
    	            pkgs.nss
    	            pkgs.openssl
    	            pkgs.curl
    	            pkgs.expat		
            ];
      };

}
