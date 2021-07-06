{ pkgs, ... }:
{
  services.grobi = {
    enable = true;
    rules = [
      {
        name = "Home";
        outputs_connected = [ "DP-3" "DP-2" ];
        configure_row = [ "DP-2" "DP-3" ];
        primary = "DP-3";
        atomic = true;
        execute_after = [
          "${pkgs.xorg.xrandr}/bin/xrandr --dpi 157"
          "${pkgs.xmonad-with-packages}/bin/xmonad --restart"
        ];
      }
    ];
  };
}
