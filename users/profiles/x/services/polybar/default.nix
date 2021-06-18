{ pkgs, config, ... }:
let
  colors = builtins.readFile ./colors.ini;
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
    extraConfig = colors;
    script = ''
      export MONITOR=DP-3
      polybar nixos 2>${config.xdg.configHome}/polybar/logs/top.log & disown
    '';
  };
}
