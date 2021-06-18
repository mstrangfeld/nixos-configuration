{ pkgs, ... }:
{
  services.screen-locker = {
    enable = true;
    inactiveInterval = 30;
    lockCmd = "${pkgs.multilockscreen}/bin/multilockscreen -l dim"; # Wrapper script for i3lock-color
    xautolockExtraOptions = [
      "Xautolock.killer: systemctl suspend"
    ];
  };
}
