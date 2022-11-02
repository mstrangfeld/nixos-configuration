# Thanks to: https://github.com/gvolpe/nix-config/
# And this awesome blog post: https://gvolpe.com/blog/xmonad-polybar-nixos/
{ config, lib, pkgs, ... }:

with lib;
let cfg = config.modules.desktop.wm.xmonad;
in {
  options.modules.desktop.wm.xmonad.enable = mkEnableOption "Xmonad";

  config = mkIf cfg.enable {
    # dconf is a low-level configuration system and settings management tool. Its main purpose is to provide a back end to GSettings on platforms that don't already have configuration storage systems
    programs.dconf.enable = true;

    services = {
      gnome.gnome-keyring.enable =
        true; # GNOME Keyring daemon, a service designed to take care of the user's security credentials, such as user names and passwords.
      upower.enable = true; # A D-Bus service for power management

      dbus = {
        enable = true;
        packages = [ pkgs.dconf ];
      };

      xserver = {
        enable = true;

        layout = "de";

        libinput = { enable = true; };

        serverLayoutSection = ''
          Option "StandbyTime" "0"
          Option "SuspendTime" "0"
          Option "OffTime"     "0"
        '';

        displayManager = {
          defaultSession = "none+xmonad";
          sessionCommands = ''
            # Disable screen blank
            ${pkgs.util-linux}/bin/setterm --blank 0 --powersave off
            # Disable screen saver blanking
            ${pkgs.xorg.xset}/bin/xset s off
            # Detect monitor setup
            ${pkgs.autorandr}/bin/autorandr -c
            # PulseAudio system tray
            ${pkgs.pasystray}/bin/pasystray &
            # NetworkManager Applet
            ${pkgs.networkmanagerapplet}/bin/nm-applet --sm-disable --indicator &
          '';
        };

        windowManager.xmonad = {
          enable = true;
          enableContribAndExtras = true;
          extraPackages = hp: [ hp.dbus hp.monad-logger hp.xmonad-contrib ];
          config = ./config.hs;
        };
      };
    };

    systemd.services.upower.enable = true;

    home-manager.users.marvin = { pkgs, ... }: {

      programs.rofi.enable = true;

      imports = [
        ../../services/autorandr.nix
        ../../services/dunst.nix
        ../../services/networkmanager.nix
        ../../services/picom.nix
        ../../services/polybar
        ../../services/screenlocker.nix
        ../../services/udiskie.nix
      ];
    };
  };
}
