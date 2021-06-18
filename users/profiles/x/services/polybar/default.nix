{ pkgs, config, ... }:
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
    script = ''
      polybar main 2>${config.xdg.configHome}/polybar/logs/top.log & disown
    '';
  };
}
