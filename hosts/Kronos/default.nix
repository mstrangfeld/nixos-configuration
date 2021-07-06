{ suites, profiles, ... }:
{
  imports = suites.kronos ++ [ ./zfs.nix ];

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
  networking.hostId = "64ada341";

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
  xdg.portal.enable = true;

  # A toolkit for defining and handling the policy that allows unprivileged processes to speak to privileged processes
  security.polkit.enable = true;
}
