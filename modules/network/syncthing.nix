{ config, lib, pkgs, ... }:
with lib;
let
  devices = {
    "Eos" = {
      id = "EJ772JS-NOTJFYU-YEXLA7L-3THNGRH-HKPP445-P6FJWP3-PRYQKEZ-RIPFWAP";
      introducer = true;
      folders = {
        "sync" = { path = "/var/lib/syncthing/sync"; };
        "documents" = { path = "/var/lib/syncthing/documents"; };
      };
    };
    "Kronos" = {
      id = "T6FCEW7-7DZ72U2-5KJGDRT-SKWDUZA-623JRJO-37FKZPD-LF4ZQWH-JK44EQP";
      folders = {
        "sync" = { path = "/home/marvin/sync"; };
        "documents" = { path = "/home/marvin/documents"; };
      };
    };
    "OnePlusA5020" = {
      id = "MJX5Z2N-BLIQPSY-ZEL6MYN-DGLFYSD-TT6WV54-PO77GLO-HHCCXAV-35AVVQV";
    };
    "OX-MacBookAir" = {
      id = "CEK3QHR-LPJ5VRW-YF67OXN-5R5GIBZ-KJDHVJV-M6L5HSO-EPYBZFK-5VNT4QR";
    };
  };

  folders = {
    "sync" = {
      id = "syncme";
      devices = [ "Eos" "Kronos" "OnePlusA5020" "OX-MacBookAir" ];
    };
    "documents" = {
      id = "documents";
      devices = [ "Eos" "Kronos" "OX-MacBookAir" ];
    };
  };
  cfg = config.modules.network.syncthing;
in
{
  options.modules.network.syncthing = {
    enable = mkEnableOption "Syncthing";
    additionalConfig = mkOption { default = { }; };
  };

  config = mkIf cfg.enable {
    services.syncthing =
      let hostName = config.networking.hostName;
      in {
        enable = true;
        openDefaultPorts = true;
        overrideDevices = true;
        overrideFolders = true;
        devices = builtins.mapAttrs
          (name: value: (attrsets.filterAttrs (n: v: n != "folders") value))
          devices;
        folders = builtins.mapAttrs
          (name: value: folders.${name} // devices.${hostName}.folders.${name})
          devices.${hostName}.folders;
      } // cfg.additionalConfig;
  };
}
