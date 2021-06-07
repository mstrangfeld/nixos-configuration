{ suites, profiles, ... }:
{
  imports = suites.base;

  system.stateVersion = "21.05";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  time.timeZone = "Europe/Berlin";

  networking.networkmanager.enable = true;

  # VIDEO AND X-SERVER

  hardware.nvidia.modesetting.enable = true; # wayland can't work without modesetting

  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];

  services.xserver.layout = "de";
  services.xserver.xkbOptions = "eurosign:e";

  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.gdm.nvidiaWayland = true;
  services.xserver.desktopManager.gnome3.enable = true;

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

  fileSystems."/" = { device = "/dev/disk/by-label/nixos"; };
  fileSystems."/boot" = { device = "/dev/disk/by-label/EFIBOOT"; };
  swapDevices = [
    { device = "/dev/disk/by-label/swap"; }
  ];
}
