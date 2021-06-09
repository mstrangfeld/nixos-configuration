{ lib, config, pkgs, ... }:

with lib;
let cfg = config.services.v4l2;
in
{
  options = {
    services.v4l2 = {
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

    boot.extraModprobeConfig = ''
      options v4l2loopback exclusive_caps=1 video_nr=9 card_label=a7III
    '';
  };
}
