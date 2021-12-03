{ config, ... }:
{
  imports = [ ./zfs.nix ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  time.timeZone = "Europe/Berlin";

  boot.kernel.sysctl = {
    "kernel.dmesg_restrict" = 0;
    "kernel.perf_event_paranoid" = 1;
    "fs.inotify.max_user_watches" = 524288;
    "vm.swappiness" = 10;
  };

  networking.hostId = "64ada341";
  networking.firewall = {
    trustedInterfaces = [
      "enp0s20u6u3" # GoPro Hero 9 for Wecam mode
    ];
    allowedUDPPortRanges = [
      { from = 1714; to = 1764; } # KDEConnect
    ];
    allowedTCPPortRanges = [
      { from = 1714; to = 1764; } # KDEConnect
    ];
  };

  # VIDEO AND X-SERVER

  hardware.nvidia.modesetting.enable = true;
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.legacy_470;

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  services.xserver = {
    enable = true;
    videoDrivers = [ "nvidia" ];

    layout = "de";
    xkbOptions = "eurosign:e";

    displayManager = {
      # Since we are on an encrypted zfs...
      autoLogin = {
        enable = true;
        user = "marvin";
      };
    };

    libinput = {
      enable = true;
      mouse = {
        accelProfile = "adaptive";
        accelSpeed = "1";
      };
    };

  };

  security.pam.services.lightdm.enableGnomeKeyring = true;

  services.v4l2loopback = {
    enable = true;
  };
  # services.usbmuxd.enable = true;

  # Can't get Rocket.Chat to work as Nix derivation
  services.flatpak.enable = true;
  xdg.portal.enable = true;

  # A toolkit for defining and handling the policy that allows unprivileged processes to speak to privileged processes
  security.polkit.enable = true;
}
