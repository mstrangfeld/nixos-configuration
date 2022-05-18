{ config, lib, pkgs, ... }:

with lib;
let cfg = config.modules.server.ankisyncd;
in {
  options.modules.server.ankisyncd.enable = mkEnableOption "AnkiSync";

  config = mkIf cfg.enable {
    services.ankisyncd = {
      enable = true;
      port = 27702;
    };

    services.nginx.virtualHosts."anki.cloud.strangfeld.io" = {
      forceSSL = true;
      enableACME = true;
      locations."/" = {
        proxyPass = "http://127.0.0.1:27702/";
      };
    };
  };
}
