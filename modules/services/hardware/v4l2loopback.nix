{ lib, config, pkgs, ... }:

with lib;
let cfg = config.services.v4l2loopback;
in
{
  options = {
    services.v4l2loopback = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = ''
          Whether to enable the v4l2 loopback device
        '';
      };
    };
  };
  config = mkIf cfg.enable {
    # Extra kernel modules
    boot.extraModulePackages = with unstable; [
      config.boot.kernelPackages.v4l2loopback
    ];

    # Register a v4l2loopback device at boot
    boot.kernelModules = [
      "v4l2loopback"
    ];

    # Create persitent devices 8 and 9 for OBS and GoPro
    boot.extraModprobeConfig = ''
      options v4l2loopback video_nr=8,9
      options v4l2loopback card_label="OBS,GoPro"
      options v4l2loopback exclusive_caps=1
    '';

    # Create the video group
    users.groups = {
      video = { };
    };

    services.udev.extraRules = ''
      # make sure that the /dev/v4l2loopback module can be used by the 'video' group
      # note: this allows all members of 'video' to create and remove v4l2loopback
      # devices....
      KERNEL=="v4l2loopback", GROUP="video"

      # persistent device names for loopback devices
      SUBSYSTEM=="video4linux", KERNEL=="video*", DEVPATH=="*/virtual/*", SYMLINK+="v4l/by-id/v4l2loopback-$attr{name}-video"

      # grant access to sysfs properties for group 'video'
      # - read access to all properties
      # - write access to 'max_openers' and 'format'
      ACTION=="add", SUBSYSTEM=="video4linux", DEVPATH=="*/virtual/*" RUN+="${pkgs.findutils}/bin/find %S%p -maxdepth 1 -type f -exec ${pkgs.coreutils}/bin/chgrp video {} +" RUN+="${pkgs.findutils}/bin/find %S%p -maxdepth 1 -type f ( -name max_openers -or -name format ) -exec ${pkgs.coreutils}/bin/chmod g+rw {} +"
    '';
  };
}
