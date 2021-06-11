{ pkgs, config, ... }:
let
  homeDirectory = config.home.homeDirectory;
in
{
  home.file = {
    lv2 = {
      source = "${homeDirectory}/.nix-profile/lib/lv2";
      target = ".lv2";
    };
    vst = {
      source = "${homeDirectory}/.nix-profile/lib/vst";
      target = ".vst";
    };
  };
}
