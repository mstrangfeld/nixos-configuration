{ pkgs, config, ... }:
let
  homeDirectory = config.home.homeDirectory;
in
{
  home.file = {
    lv2 = {
      source = "/run/current-system/sw/lib/lv2";
      target = ".lv2";
    };
    vst = {
      source = "/run/current-system/sw/lib/vst";
      target = ".vst";
    };
  };
}
