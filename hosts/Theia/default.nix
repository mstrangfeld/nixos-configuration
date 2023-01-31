{ config, pkgs, lib, ... }:

{
  system.stateVersion = "22.11"; # Did you read the comment?
  home-manager.users.marvin.home.stateVersion = "22.11";

  imports = [ ./hardware-configuration.nix ];

  boot.kernelPackages = pkgs.linuxPackages_6_1;

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

  networking.hostId = "4742ed61";
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

  services.xserver = {
    enable = true;

    # Enable the Plasma 5 Desktop Environment.
    displayManager.sddm.enable = true;
    desktopManager.plasma5.enable = true;

    # Configure keymap in X11
    layout = "de";
    xkbOptions = "eurosign:e";
  };

  # AMD GPU
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.marvin = { password = "secret"; };

  users.users.root.password = "secret";

  environment.etc."nixos" = { source = "/persist/etc/nixos/"; };
  environment.etc."NetworkManager/system-connections" = { source = "/persist/etc/NetworkManager/system-connections"; };

  modules = {
    desktop = {
      enable = true;
      audio.enable = true;
      browser = {
        default = "brave";
        brave.enable = true;
        firefox.enable = true;
      };
      creative = {
        graphics.enable = true;
        music.enable = true;
      };
      email.enable = true;
      games.enable = true;
      v4l2loopback.enable = true;
      yubikey.enable = true;
    };
    development = {
      enable = true;
      rust.enable = true;
    };
    development.virtualisation.enable = true;
    network.enable = true;
    shell.enable = true;
    theme.enable = true;
  };
}
