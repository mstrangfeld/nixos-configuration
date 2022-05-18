{ config, lib, pkgs, ... }:

with lib;
let cfg = config.modules.server.nextcloud;
in {
  options.modules.server.nextcloud = {
    enable = mkEnableOption "NextCloud";
  };

  config = mkIf cfg.enable {
    services.nginx.virtualHosts = {
      "next.cloud.strangfeld.io" = {
        forceSSL = true;
        enableACME = true;
      };
    };

    services.nextcloud = {
      enable = true;
      package = pkgs.nextcloud23;
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
        dbhost = "/run/postgresql"; # nextcloud will add /.s.PGSQL.5432 by itself
        dbname = "nextcloud";
        dbpassFile = config.age.secrets.dbPass.path;

        adminpassFile = config.age.secrets.adminPass.path;
        adminuser = "admin";
      };

      phpOptions = {};

      extraApps = {
        calendar = pkgs.fetchNextcloudApp {
          name = "Calendar";
          url = "https://github.com/nextcloud-releases/calendar/releases/download/v3.3.0/calendar-v3.3.0.tar.gz";
          version = "3.3.0";
          sha256 = "sha256-nyJ8VUvftzHbSGpR12P3tl3QRR3FioiEYMlJ7DZxPJg=";
        };
        contacts = pkgs.fetchNextcloudApp {
          name = "Contacts";
          url = "https://github.com/nextcloud-releases/contacts/releases/download/v4.1.0/contacts-v4.1.0.tar.gz";
          version = "4.1.0";
          sha256 = "sha256-jGmmDpt7joyBpL4G0eL5UYDnVW6QdLet0H7khhjqbSA=";
        };
        cookbook = pkgs.fetchNextcloudApp {
          name = "Cookbook";
          url = "https://github.com/nextcloud/cookbook/releases/download/v0.9.12/Cookbook-0.9.12.tar.gz";
          version = "0.9.12";
          sha256 = "sha256-3+BqcXnY9tdz9sQ0GsRQQr8skBLV35L8drc/l1bxK60=";
        };
        cospend = pkgs.fetchNextcloudApp {
          name = "Cospend";
          url = "https://github.com/eneiluj/cospend-nc/releases/download/v1.4.6/cospend-1.4.6.tar.gz";
          version = "1.4.6";
          sha256 = "sha256-Kjgd5m2fZIExvZ09kq4aVM32CzL6U2PM/wvB6+Dn/e8=";
        };
        deck = pkgs.fetchNextcloudApp {
          name = "Deck";
          url = "https://github.com/nextcloud-releases/deck/releases/download/v1.6.1/deck-v1.6.1.tar.gz";
          version = "1.6.1";
          sha256 = "sha256-Ze20arex7AZhHnSWIPN8DlAtalp+/Rl7qwTA+IBv3vo=";
        };
        forms = pkgs.fetchNextcloudApp {
          name = "Forms";
          url = "https://github.com/nextcloud-releases/forms/releases/download/v2.5.0/forms-v2.5.0.tar.gz";
          version = "2.5.0";
          sha256 = "sha256-qhffuIrL5GYNal5FRbvNplchoc1HRcLjRZUbirppc+w=";
        };
        gpoddersync = pkgs.fetchNextcloudApp {
          name = "GPodder Sync";
          url = "https://github.com/thrillfall/nextcloud-gpodder/releases/download/3.3.0/gpoddersync.tar.gz";
          version = "3.3.0";
          sha256 = "sha256-UhQ1ByyWsy4xdynLOmFQyN4CyEiKh6I2HAP+1Cr1XxY=";
        };
        groupfolders = pkgs.fetchNextcloudApp {
          name = "Group folders";
          url = "https://github.com/nextcloud-releases/groupfolders/releases/download/v11.1.4/groupfolders-v11.1.4.tar.gz";
          version = "11.1.4";
          sha256 = "sha256-OWgVhPEPc/m7N2cUAfJKGMKYYk8yDTdAvCfvO9XjtxA=";
        };
        polls = pkgs.fetchNextcloudApp {
          name = "Polls";
          url = "https://github.com/nextcloud/polls/releases/download/v3.6.1/polls.tar.gz";
          version = "3.6.1";
          sha256 = "sha256-32w8kx2eS+TpsH4kjGym5JWDjG2h9kX3kEVpfOfUDjQ=";
        };
        spreed = pkgs.fetchNextcloudApp {
          name = "Talk";
          url = "https://github.com/nextcloud-releases/spreed/releases/download/v13.0.5/spreed-v13.0.5.tar.gz";
          version = "13.0.5";
          sha256 = "sha256-566oKMVRBjaZ69Ntg4zC7rjW01u0GF4RT4vJnzIl2Zk=";
        };
      };
    };

    environment.systemPackages = with pkgs;[
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
