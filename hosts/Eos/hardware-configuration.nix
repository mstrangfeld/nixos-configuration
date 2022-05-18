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
      device = "/dev/disk/by-uuid/9090-2210";
      fsType = "vfat";
    };

  swapDevices =
    [{ device = "/dev/disk/by-uuid/e34f7bf4-b88f-462f-8cb2-e010a9d1d43f"; }];

  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
