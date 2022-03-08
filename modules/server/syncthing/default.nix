{ config, lib, pkgs, ... }:

with lib;
let cfg = config.modules.server.syncthing;
in {
  options.modules.server.syncthing = {
    enable = mkEnableOption "Syncthing";
  };

  config = mkIf cfg.enable {
    services.syncthing = {
      enable = true;
      openDefaultPorts = true;
    };
  };
}
