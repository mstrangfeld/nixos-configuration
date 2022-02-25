{ config, lib, pkgs, ... }:

with lib;
let cfg = config.modules.server;
in {
  imports = [
    ./nextcloud
    ./syncthing
  ];

  options.modules.server.enable = mkEnableOption "Server";

  config = mkIf cfg.enable {
  };
}
