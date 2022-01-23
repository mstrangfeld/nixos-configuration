{ pkgs, ... }:
{
  xsession = {
    enable = true;

    initExtra = ''
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

    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
      extraPackages = hp: [
        hp.dbus
        hp.monad-logger
        hp.xmonad-contrib
      ];
      config = ./config.hs;
    };
  };
}
