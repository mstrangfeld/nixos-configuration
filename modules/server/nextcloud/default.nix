{ config, lib, pkgs, ... }:

with lib;
let cfg = config.modules.server.nextcloud;
in {
  options.modules.server.nextcloud = {
    enable = mkEnableOption "NextCloud";
  };

  config = mkIf cfg.enable {
    services.nginx.virtualHosts = {
      "cloud.strangfeld.io" = {
        forceSSL = true;
        enableACME = true;
      };
    };

    services.nextcloud = {
      enable = true;
      hostName = "cloud.strangfeld.io";
      nginx.enable = true;

      # Use HTTPS for links
      https = true;

      # Auto-update Nextcloud Apps
      autoUpdateApps.enable = true;
      # Set what time makes sense for you
      autoUpdateApps.startAt = "05:00:00";

      config = {
        # Further forces Nextcloud to use HTTPS
        overwriteProtocol = "https";

        # Nextcloud PostegreSQL database configuration, recommended over using SQLite
        dbtype = "pgsql";
        dbuser = "nextcloud";
        dbhost = "/run/postgresql"; # nextcloud will add /.s.PGSQL.5432 by itself
        dbname = "nextcloud";
        dbpassFile = "/var/nextcloud-db-pass";

        adminpassFile = "/var/nextcloud-admin-pass";
        adminuser = "admin";
      };
    };

    services.postgresql = {
      enable = true;

      # Ensure the database, user, and permissions always exist
      ensureDatabases = [ "nextcloud" ];
      ensureUsers = [
        {
          name = "nextcloud";
          ensurePermissions."DATABASE nextcloud" = "ALL PRIVILEGES";
        }
      ];
    };

    systemd.services."nextcloud-setup" = {
      requires = ["postgresql.service"];
      after = ["postgresql.service"];
    };
  };
}
