{ pkgs, ... }:
{
  services.grobi = {
    enable = true;
    rules = [
      {
        name = "Home";
        outputs_connected = [ "DP-3" ];
        configure_single = "DP-3";
        primary = true;
        atomic = true;
        execute_after = [
          "${pkgs.xorg.xrandr}/bin/xrandr --dpi 157"
          "${pkgs.xmonad-with-packages}/bin/xmonad --restart"
        ];
      }
    ];
  };
}
