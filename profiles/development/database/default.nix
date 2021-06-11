{ pkgs, ... }:
{
  environment = {
    systemPackages = with pkgs; [
      pgcli # Command-line interface for PostgreSQL
    ];
  };
}
