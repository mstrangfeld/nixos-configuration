{ config, lib, pkgs, ... }:

with lib;
let cfg = config.modules;
in {
  imports = [
    ./core
    ./desktop
    ./development
    ./network
    ./server
    ./shell
    ./theme
    ./work
  ];
}
