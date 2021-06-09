{ suites, profiles, ... }:
{
  imports = suites.base;

  system.stateVersion = "21.05";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  time.timeZone = "Europe/Berlin";

  boot.kernel.sysctl = {
    "kernel.dmesg_restrict" = 0;
    "kernel.perf_event_paranoid" = 1;
    "fs.inotify.max_user_watches" = 524288;
    "kernel.unprivileged_userns_clone" = 1;
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

    displayManager.sddm.enable = true;
    desktopManager.plasma5.enable = true;
  };

  services.v4l2 = {
    enable = true;
  };

  # AUDIO AND PIPEWIRE

  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  virtualisation = {
    podman = {
      enable = true;
    };
    docker = {
      enable = true;
      enableNvidia = true;
    };
  };

  fileSystems."/" = { device = "/dev/disk/by-label/nixos"; };
  fileSystems."/boot" = { device = "/dev/disk/by-label/EFIBOOT"; };
  swapDevices = [
    { device = "/dev/disk/by-label/swap"; }
  ];
}
