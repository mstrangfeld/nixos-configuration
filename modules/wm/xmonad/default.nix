# Thanks to: https://github.com/gvolpe/nix-config/
# And this awesome blog post: https://gvolpe.com/blog/xmonad-polybar-nixos/
{ pkgs, ... }:
{
  # dconf is a low-level configuration system and settings management tool. Its main purpose is to provide a back end to GSettings on platforms that don't already have configuration storage systems
  programs.dconf.enable = true;

  services = {
    gnome.gnome-keyring.enable = true; # GNOME Keyring daemon, a service designed to take care of the user's security credentials, such as user names and passwords.
    upower.enable = true; # A D-Bus service for power management

    dbus = {
      enable = true;
      packages = [ pkgs.gnome3.dconf ];
    };

    xserver = {
      enable = true;

      layout = "de";

      libinput = {
        enable = true;
      };

      serverLayoutSection = ''
        Option "StandbyTime" "0"
        Option "SuspendTime" "0"
        Option "OffTime"     "0"
      '';

      displayManager = {
        defaultSession = "none+xmonad";
      };

      windowManager.xmonad = {
        enable = true;
        enableContribAndExtras = true;
      };
    };
  };

  systemd.services.upower.enable = true;
}
