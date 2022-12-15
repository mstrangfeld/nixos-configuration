{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.modules.desktop.games;
in
{
  options.modules.desktop.games.enable = mkEnableOption "Games";

  config = mkIf cfg.enable {
    programs.steam.enable = true;
    programs.gamemode.enable = true;

    environment = {
      systemPackages = with pkgs; [
        lutris # Open Source gaming platform for GNU/Linux
        minecraft # Official launcher for Minecraft, a sandbox-building game
        minetest # Infinite-world block sandbox game
        ttyper # Terminal-based typing test
        xboxdrv # Xbox/Xbox360 (and more) gamepad driver for Linux that works in userspace
      ];
    };
  };
}
