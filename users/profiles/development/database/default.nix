{ pkgs, ... }:
{
  home.packages = with pkgs; [
    pgcli # Command-line interface for PostgreSQL
  ];
}
