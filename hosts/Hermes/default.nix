{ config, pkgs, lib, modulesPath, ... }:
{
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"

    # Provide an initial copy of the NixOS channel so that the user
    # doesn't need to run "nix-channel --update" first.
    "${modulesPath}/installer/cd-dvd/channel.nix"
  ];

  system.stateVersion = "22.11"; # Did you read the comment?
  home-manager.users.marvin.home.stateVersion = "22.11";

  boot.kernelPackages = pkgs.linuxPackages_6_1;

  users.users.marvin = { password = "secret"; };

  users.users.root.password = "secret";

  services.xserver = {
    enable = true;
    # Enable the Plasma 5 Desktop Environment.
    displayManager.sddm.enable = true;
    desktopManager.plasma5.enable = true;
    # Configure keymap in X11
    layout = "de";
    xkbOptions = "eurosign:e";
  };

  modules = {
    desktop = {
      enable = true;
      audio.enable = true;
      browser = {
        default = "brave";
        brave.enable = true;
        firefox.enable = true;
      };
      yubikey.enable = true;
    };
    network.enable = false;
    shell.enable = true;
    theme.enable = true;
  };
}
