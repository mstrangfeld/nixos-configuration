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
            patterns =
              [ "INBOX" "Sent" "Trash" "Drafts" "Junk" "Archive" "Archive/*" ];
            create = "both";
            expunge = "both";
            extraConfig.channel = { CopyArrivalDate = "yes"; };
          };
          mu.enable = true;
        };
        rwth = {
          address = "marvin.strangfeld@rwth-aachen.de";
          primary = false;
          realName = name;
          userName = "io782677@rwth-aachen.de";
          passwordCommand = "secret-tool lookup password mail.rwth-aachen.de";
          imap = {
            host = "mail.rwth-aachen.de";
            port = 993;
            tls.enable = true;
          };
          smtp = {
            host = "mail.rwth-aachen.de";
            port = 587;
            tls.enable = true;
            tls.useStartTls = true;
          };
          msmtp.enable = true;
          mbsync = {
            enable = true;
            patterns = [
              "INBOX"
              "Sent Items"
              "Deleted Items"
              "Drafts"
              "Junk Email"
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
