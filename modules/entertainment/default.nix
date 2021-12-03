{ pkgs, ... }:
{

  programs.steam.enable = true;

  environment = {
    systemPackages = with pkgs; [
      minecraft # Official launcher for Minecraft, a sandbox-building game
      ttyper # Terminal-based typing test
      xboxdrv # Xbox/Xbox360 (and more) gamepad driver for Linux that works in userspace
    ];
  };
}
