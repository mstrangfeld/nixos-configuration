{ config, lib, pkgs, ... }:

with lib;
let cfg = config.modules.server.nextcloud;
in {
  options.modules.server.nextcloud = { enable = mkEnableOption "NextCloud"; };

  config = mkIf cfg.enable {
    services.nginx.virtualHosts = {
      "next.cloud.strangfeld.io" = {
        forceSSL = true;
        enableACME = true;
      };
    };

    services.nextcloud = {
      enable = true;
      package = pkgs.nextcloud24;
      hostName = "next.cloud.strangfeld.io";

      datadir = "/data/nextcloud";

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
        dbhost =
          "/run/postgresql"; # nextcloud will add /.s.PGSQL.5432 by itself
        dbname = "nextcloud";
        dbpassFile = config.age.secrets.dbPass.path;

        adminpassFile = config.age.secrets.adminPass.path;
        adminuser = "admin";
      };

      phpOptions = { };

      extraApps = {
        calendar = pkgs.fetchNextcloudApp rec {
          name = "Calendar";
          url =
            "https://github.com/nextcloud-releases/calendar/releases/download/v${version}/calendar-v${version}.tar.gz";
          version = "3.4.3";
          sha256 = "sha256-UN4ultm0tgpt4uG8DaD5tLXDIfSAR2Ye6EHFp0+m6zs=";
        };
        contacts = pkgs.fetchNextcloudApp rec {
          name = "Contacts";
          url =
            "https://github.com/nextcloud-releases/contacts/releases/download/v${version}/contacts-v${version}.tar.gz";
          version = "4.2.0";
          sha256 = "sha256-Oo7EFKlXxAAFFPQZzrpOx+6dpBb78r/yPxpDs6Cgw04=";
        };
        gpoddersync = pkgs.fetchNextcloudApp rec {
          name = "GPodder Sync";
          url =
            "https://github.com/thrillfall/nextcloud-gpodder/releases/download/${version}/gpoddersync.tar.gz";
          version = "3.4.0";
          sha256 = "sha256-G/9eLZsNpfIs59c/eiDV9/ybkwO11p3jzxWdLd7Q9AE=";
        };
        bookmarks = pkgs.fetchNextcloudApp rec {
          name = "Bookmarks";
          url =
            "https://github.com/nextcloud/bookmarks/releases/download/v${version}/bookmarks-${version}.tar.gz";
          version = "11.0.1";
          sha256 = "sha256-O2cEDdtg0Z8+Npgj6K508wQXApsSX3hDgvso+QNI/kI=";
        };
        mail = pkgs.fetchNextcloudApp rec {
          name = "Mail";
          url =
            "https://github.com/nextcloud-releases/mail/releases/download/v${version}/mail-v${version}.tar.gz";
          version = "1.13.8";
          sha256 = lib.fakeSha256;
        };
      };
    };

    environment.systemPackages = with pkgs; [
      graphicsmagick
      ffmpeg
      ghostscript
    ];

    age.secrets.dbPass = {
      file = ../../../secrets/passwords/nextcloud-db-pass.age;
      owner = "nextcloud";
      group = "nextcloud";
      path = "/var/lib/nextcloud/nextcloud-db-pass";
      symlink = false;
    };
    age.secrets.adminPass = {
      file = ../../../secrets/passwords/nextcloud-admin-pass.age;
      owner = "nextcloud";
      group = "nextcloud";
      path = "/var/lib/nextcloud/nextcloud-admin-pass";
      symlink = false;
    };

    services.postgresql = {
      enable = true;
      dataDir = "/data/postgres";

      # Ensure the database, user, and permissions always exist
      ensureDatabases = [ "nextcloud" ];
      ensureUsers = [{
        name = "nextcloud";
        ensurePermissions."DATABASE nextcloud" = "ALL PRIVILEGES";
      }];
    };

    systemd.services."nextcloud-setup" = {
      requires = [ "postgresql.service" ];
      after = [ "postgresql.service" ];
    };
  };
}
