{ pkgs, ... }:
{
  home.file = {
    lv2 = {
      source = "$HOME/.nix-profile/lib/lv2";
      target = ".lv2";
    };
    vst = {
      source = "$HOME/.nix-profile/lib/vst";
      target = ".vst";
    };
  };
}
