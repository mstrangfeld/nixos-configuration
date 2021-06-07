{ suites, profiles, ... }:
{
  imports = [ suites.base suites.workstation ];

  system.stateVersion = "21.05";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  time.timeZone = "Europe/Berlin";

  networking.useDHCP = true;
  networking.networkmanager.enable = true;

  fileSystems."/" = { device = "/dev/disk/by-label/nixos"; };
  fileSystems."/boot" = { device = "/dev/disk/by-label/boot"; };
  swapDevices = [
    { device = "/dev/disk/by-label/swap"; }
  ];
}
