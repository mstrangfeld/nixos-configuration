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

  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;

    layout = "de";
    xkbVariant = "eurosign:e";

    libinput = { enable = true; };
  };

  programs.xwayland.enable = true;

  console.keyMap = "de";

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
      gnome.enable = true;
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
  };

}
