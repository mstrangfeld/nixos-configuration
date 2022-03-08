{ config, lib, pkgs, ... }:

with lib;
let cfg = config.modules.server.ankisyncd;
in {
  options.modules.server.ankisyncd.enable = mkEnableOption "AnkiSync";

  config = mkIf cfg.enable {
    services.ankisyncd = {
      enable = true;
    };

    services.nginx.virtualHosts =
      let
        ankiSyncPort = config.services.ankisyncd.port;
      in {
      "anki.cloud.strangfeld.io" = {
        forceSSL = true;
        locations."/" = {
          proxyPass = "http://127.0.0.1:${toString ankiSyncPort}/";
        };
      };
    };
  };
}
