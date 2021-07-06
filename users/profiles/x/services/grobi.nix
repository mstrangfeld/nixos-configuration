{ pkgs, ... }:
{
  services.grobi = {
    enable = true;
    rules = [
      {
        name = "Home";
        outputs_connected = [ "DP-3" "DP-2" ];
        atomic = true;
        execute_after = [
          "${pkgs.xorg.xrandr} --output DVI-I-0 --off --output DVI-I-1 --off --output DP-0 --off --output DP-1 --off --output DP-2 --mode 1920x1080 --pos 0x120 --rotate right --output DP-3 --primary --mode 3840x2160 --pos 1080x0 --rotate normal"
          "${pkgs.xorg.xrandr}/bin/xrandr --dpi 157"
          "${pkgs.nitrogen}/bin/nitrogen --restore"
          "${pkgs.xmonad-with-packages}/bin/xmonad --restart"
        ];
      }
    ];
  };
}
