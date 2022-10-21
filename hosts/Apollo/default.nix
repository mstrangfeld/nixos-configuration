{ config, pkgs, ... }:

{
  system.stateVersion = "22.05";
  home-manager.users.marvin.home.stateVersion = "22.05";

  imports = [ ./hardware-configuration.nix ];

  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    loader.efi.efiSysMountPoint = "/boot/efi";

    # Setup keyfile
    initrd.secrets = { "/crypto_keyfile.bin" = null; };

    # Enable swap on luks
    initrd.luks.devices."luks-4006be7b-397a-45fe-a34a-f3b0cf32f1a5".device =
      "/dev/disk/by-uuid/4006be7b-397a-45fe-a34a-f3b0cf32f1a5";
    initrd.luks.devices."luks-4006be7b-397a-45fe-a34a-f3b0cf32f1a5".keyFile =
      "/crypto_keyfile.bin";
  };

  time.timeZone = "Europe/Berlin";

  hardware.nvidia.modesetting.enable = true;
  hardware.nvidia.prime = {
    offload.enable = true;

    # Bus ID of the Intel GPU. You can find it using lspci, either under 3D or VGA
    intelBusId = "PCI:0:2:0";

    # Bus ID of the NVIDIA GPU. You can find it using lspci, either under 3D or VGA
    nvidiaBusId = "PCI:1:0:0";
  };

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

    libinput = { enable = true; };
  };

  security.pam.services.lightdm.enableGnomeKeyring = true;

  # Can't get Rocket.Chat to work as Nix derivation
  services.flatpak.enable = true;
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  # A toolkit for defining and handling the policy that allows unprivileged processes to speak to privileged processes
  security.polkit.enable = true;

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
      gnome.enable = false;
      wm.xmonad.enable = true;
      yubikey.enable = true;
    };
    development = {
      enable = true;
      go.enable = true;
      haskell.enable = true;
      java.enable = true;
      javascript.enable = true;
      kubernetes.enable = true;
      markup.enable = true;
      python.enable = true;
      rust.enable = true;
      sql.enable = true;
      virtualisation.enable = true;
    };
    network.enable = true;
    shell.enable = true;
    theme.enable = true;
    work = { open-xchange = true; };
  };

}
