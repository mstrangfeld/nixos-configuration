{ config, pkgs, lib, ... }:

{
  system.stateVersion = "22.11"; # Did you read the comment?
  home-manager.users.marvin.home.stateVersion = "22.11";

  imports = [ ./hardware-configuration.nix ];

  boot.kernelPackages = pkgs.linuxPackages_6_1;
  boot.initrd.kernelModules = [ "nvidia" ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 50;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernel.sysctl = {
    "kernel.dmesg_restrict" = 0;
    "kernel.perf_event_paranoid" = 1;
    "fs.inotify.max_queued_events" = 524288;
    "fs.inotify.max_user_instances" = 524288;
    "fs.inotify.max_user_watches" = 524288;
    "vm.swappiness" = 10;
  };

  time.timeZone = "Europe/Berlin";

  networking.hostId = "d927effc";
  networking.firewall = {
    allowedUDPPortRanges = [{
      from = 1714;
      to = 1764;
    } # KDEConnect
    ];
    allowedTCPPortRanges = [{
      from = 1714;
      to = 1764;
    } # KDEConnect
    ];
  };

  hardware.nvidia.modesetting.enable = true;
  hardware.nvidia.prime = {
    offload.enable = true;

    # Bus ID of the Intel GPU. You can find it using lspci, either under 3D or VGA
    intelBusId = "PCI:0:2:0";

    # Bus ID of the NVIDIA GPU. You can find it using lspci, either under 3D or VGA
    nvidiaBusId = "PCI:3:0:0";
  };
  services.xserver = {
    enable = true;

    videoDrivers = [ "nvidia" ];

    # Enable the Plasma 5 Desktop Environment.
    displayManager.sddm.enable = true;
    desktopManager.plasma5.enable = true;

    # Configure keymap in X11
    layout = "de";
    xkbOptions = "eurosign:e";

    libinput = { enable = true; };
  };

  programs.dconf.enable = true;

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.marvin = { password = "secret"; };

  users.users.root.password = "secret";

  modules = {
    desktop = {
      enable = true;
      audio.enable = true;
      browser = {
        default = "brave";
        brave.enable = true;
        firefox.enable = true;
      };
      email.enable = true;
      yubikey.enable = true;
    };
    development = {
      enable = true;
    };
    network.enable = true;
    shell.enable = true;
    theme.enable = true;
  };
}
