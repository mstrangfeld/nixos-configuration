{ options, config, lib, pkgs, ... }:

with lib;
let cfg = config.modules.development.sql;
in {
  options.modules.development.sql.enable = mkEnableOption "SQL";

  config = mkIf cfg.enable {
    environment = {
      systemPackages = with pkgs; [
        pgcli # Command-line interface for PostgreSQL
      ];
    };
  };
}
