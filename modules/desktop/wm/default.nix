{ config, lib, pkgs, ... }:

with lib;
let cfg = config.modules.desktop.wm;
in {
  imports = [
    ./xmonad
  ];
}
