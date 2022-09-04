{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.modules.desktop.email;
  name = "Marvin Strangfeld";
  maildir = "/home/marvin/.mail";
in {
  options.modules.desktop.email = { enable = mkEnableOption "E-Mail"; };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ mu isync libsecret ];

    home-manager.users.marvin = { pkgs, ... }: {
      accounts.email.maildirBasePath = maildir;
      accounts.email.accounts = {
        strangfeld-io = {
          address = "marvin@strangfeld.io";
          primary = true;
          realName = name;
          userName = "marvin@strangfeld.io";
          passwordCommand = "secret-tool lookup password mailbox.org";
          imap = {
            host = "imap.mailbox.org";
            port = 993;
            tls.enable = true;
          };
          smtp = {
            host = "smtp.mailbox.org";
            port = 465;
            tls.enable = true;
          };
          msmtp.enable = true;
          mbsync = {
            enable = true;
            patterns = [
              "INBOX"
              "INBOX/*"
              "Sent"
              "Trash"
              "Drafts"
              "Junk"
              "Archive"
              "Archive/*"
            ];
            create = "both";
            expunge = "both";
            extraConfig.channel = { CopyArrivalDate = "yes"; };
          };
          mu.enable = true;
        };
      };

      programs.mbsync.enable = true;
      programs.msmtp.enable = true;

      services.mbsync = {
        enable = true;
        frequency = "*:0/15";
        postExec = "${pkgs.mu}/bin/mu index";
      };
    };
  };
}
