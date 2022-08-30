{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/profiles/qemu-guest.nix") ];

  boot.initrd.availableKernelModules = [ "ata_piix" "uhci_hcd" "virtio_pci" "virtio_scsi" "sd_mod" "sr_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    {
      device = "rpool/root/nixos";
      fsType = "zfs";
    };

  fileSystems."/home" =
    {
      device = "rpool/home";
      fsType = "zfs";
    };

  fileSystems."/data" =
    {
      device = "rpool/data";
      fsType = "zfs";
    };

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-uuid/4684-84D8";
      fsType = "vfat";
    };

  swapDevices =
    [{ device = "/dev/disk/by-uuid/2ffae6a5-dd5e-46a6-b2cd-057c33b0d3d5"; }];

  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
