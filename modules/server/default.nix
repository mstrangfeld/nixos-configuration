{ config, lib, pkgs, ... }:

with lib;
let cfg = config.modules.server;
in {
  imports = [
    ./nextcloud
    ./pdns
  ];

  options.modules.server.enable = mkEnableOption "Server";

  config = mkIf cfg.enable {
    networking.firewall.allowedTCPPorts = [ 80 443 ];

    services.fail2ban = {
      enable = true;
    };

    security.acme = {
      acceptTerms = true;
      defaults.email = "marvin@strangfeld.io";
    };

    services.nginx = {
      enable = true;

      virtualHosts."cloud.strangfeld.io" = {
        forceSSL = true;
        enableACME = true;
        root = "/var/www/example";
      };

      # Use recommended settings
      recommendedGzipSettings = true;
      recommendedOptimisation = true;
      recommendedProxySettings = true;
      recommendedTlsSettings = true;

      # Only allow PFS-enabled ciphers with AES256
      sslCiphers = "AES256+EECDH:AES256+EDH:!aNULL";
    };
  };
}
