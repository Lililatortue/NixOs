{ self, inputs, ...}:
{
      flake.nixosModules.myMachineHardware = { config, lib, pkgs, modulesPath, ... }:
      { 
            imports = [ 
                  (modulesPath + "/installer/scan/not-detected.nix")
            ];

            boot.initrd.availableKernelModules = [ "xhci_pci" "thunderbolt" "nvme" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];

            boot.initrd.kernelModules = [ ];
            boot.kernelModules = [ "kvm-intel" ];
            boot.extraModulePackages = [ ];

            fileSystems."/" =
            { 
                  device = "/dev/disk/by-uuid/278c46ec-ad1e-4c2f-9b84-17129371b316";
                  fsType = "ext4";
            };

            fileSystems."/boot" =
            { 
                  device = "/dev/disk/by-uuid/95FC-C80D";
                  fsType = "vfat";
                  options = [ "fmask=0077" "dmask=0077" ];
            };

            swapDevices = [ 
	            { device = "/dev/disk/by-uuid/f5a5a0f1-6d99-49ac-8325-efa3ef7f16d2"; }
            ];

            nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
            hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
      };
}
