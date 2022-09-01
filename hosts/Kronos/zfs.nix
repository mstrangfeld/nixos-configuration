{ ... }: {
  boot = {
    zfs = {
      enableUnstable =
        true; # Use the unstable zfs package. Required for running newer Kernels
    };

    initrd.supportedFilesystems =
      [ "zfs" ]; # Support zfs in the initial ramdisk
    supportedFilesystems = [ "zfs" ]; # Support zfs at boot

    loader.grub.copyKernels =
      true; # To avoid errors when the hardlinks in the nix store get very high
  };

  fileSystems."/" = {
    device = "tank/safe/nixos";
    fsType = "zfs";
  };
  fileSystems."/home" = {
    device = "tank/safe/home";
    fsType = "zfs";
  };
  fileSystems."/tmp" = {
    device = "tank/safe/tmp";
    fsType = "zfs";
  };
  fileSystems."/nix" = {
    device = "tank/local/nix";
    fsType = "zfs";
  };
  fileSystems."/var/lib/docker" = {
    device = "/dev/zvol/tank/local/docker";
    fsType = "ext4";
    options =
      [ "noatime" "data=writeback" "barrier=0" "nobh" "errors=remount-ro" ];
  };
  fileSystems."/boot" = {
    device =
      "/dev/disk/by-id/ata-Samsung_SSD_870_EVO_2TB_S621NF0R417814B-part3";
  };
  swapDevices = [{
    device =
      "/dev/disk/by-id/ata-Samsung_SSD_870_EVO_2TB_S621NF0R417814B-part2";
  }];
}
