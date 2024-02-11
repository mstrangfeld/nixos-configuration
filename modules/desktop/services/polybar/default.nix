{ pkgs, config, ... }:
let
  colors = builtins.readFile ./colors.ini;
  xmonad = ''
    [module/xmonad]
    type = custom/script
    exec = ${pkgs.xmonad-log}/bin/xmonad-log
    tail = true
  '';
in
{
  # A fast and easy-to-use tool for creating status bars
  services.polybar = {
    enable = true;
    package = pkgs.polybar.override {
      alsaSupport = false;
      pulseSupport = true;
      mpdSupport = true;
    };
    config = ./config.ini;
    extraConfig = colors + xmonad;
    script = ''
      polybar nixos & disown
    '';
  };
}
