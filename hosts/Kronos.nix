{ suites, profiles, ... }:
{
  imports = suites.kronos;

  system.stateVersion = "21.05";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  time.timeZone = "Europe/Berlin";

  boot.kernel.sysctl = {
    "kernel.dmesg_restrict" = 0;
    "kernel.perf_event_paranoid" = 1;
    "fs.inotify.max_user_watches" = 524288;
    "vm.swappiness" = 10;
  };

  networking.networkmanager.enable = true;

  # VIDEO AND X-SERVER

  hardware.nvidia.modesetting.enable = true;

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
  };

  services.v4l2 = {
    enable = true;
  };
  # services.usbmuxd.enable = true;

  # Can't get Rocket.Chat to work as Nix derivation
  services.flatpak.enable = true;

  fileSystems."/" = { device = "/dev/disk/by-label/nixos"; };
  fileSystems."/boot" = { device = "/dev/disk/by-label/EFIBOOT"; };
  swapDevices = [
    { device = "/dev/disk/by-label/swap"; }
  ];
}
