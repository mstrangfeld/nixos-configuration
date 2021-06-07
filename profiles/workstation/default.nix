{ self, config, lib, pkgs, ... }:
{
  services.xserver.enable = true;
  services.xserver.layout = "de-latin1";
  services.xserver.xkbOptions = "eurosign:e";

  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome3.enable = true;

  programs.alacritty = {
    enable = true;
    settings = {
      window.startup_mode = "Maximized";
    };
  };
}
