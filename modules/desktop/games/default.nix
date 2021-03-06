{ config, lib, pkgs, ... }:

with lib;
let cfg = config.modules.desktop.games;
in {
  options.modules.desktop.games.enable = mkEnableOption "Games";

  config = mkIf cfg.enable {
    programs.steam.enable = true;
    programs.gamemode.enable = true;

    environment = {
      systemPackages = with pkgs; [
        minecraft # Official launcher for Minecraft, a sandbox-building game
        ttyper # Terminal-based typing test
        xboxdrv # Xbox/Xbox360 (and more) gamepad driver for Linux that works in userspace
      ];
    };
  };
}
