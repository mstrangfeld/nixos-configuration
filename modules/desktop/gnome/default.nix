{ config, lib, pkgs, ... }:

with lib;
let cfg = config.modules.desktop.gnome;
in {
  options.modules.desktop.gnome.enable = mkEnableOption "Gnome Desktop";

  config = mkIf cfg.enable {
    services = {
      xserver = {
        enable = true;
        displayManager.gdm.enable = true;
        desktopManager.gnome.enable = true;
      };
      gnome = {
        gnome-keyring.enable = true;
      };
      udev.packages = with pkgs; [
        gnome.gnome-settings-daemon
      ];
    };

    programs = {
      dconf.enable = true;
      gnome-disks.enable = true;
      seahorse.enable = true;
    };

    # Exclude some default applications
    environment.gnome.excludePackages = (with pkgs; [
      gnome-photos
      gnome-tour
    ]) ++ (with pkgs.gnome; [
      cheese # webcam tool
      gnome-music
      gnome-terminal
      gedit # text editor
      epiphany # web browser
      geary # email reader
      # evince # document viewer
      gnome-characters
      totem # video player
      tali # poker game
      iagno # go game
      hitori # sudoku game
      atomix # puzzle game
    ]);

    environment.systemPackages = with pkgs; [
      gnome.adwaita-icon-theme
      gnomeExtensions.appindicator
    ];
  };
}
