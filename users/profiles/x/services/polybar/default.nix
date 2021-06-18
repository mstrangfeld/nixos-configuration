{ pkgs, ... }:
{
  # A fast and easy-to-use tool for creating status bars
  services.polybar = {
    enable = true;
    package = pkgs.polybar.override {
      alsaSupport = false;
      pulseSupport = true;
      mpdSupport = true;
    };
  };
}
