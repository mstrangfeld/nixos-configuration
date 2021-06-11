{ pkgs, ... }:
{
  environment = {
    systemPackages = with pkgs; [
      minecraft # Official launcher for Minecraft, a sandbox-building game
      steam # A digital distribution platform
      ttyper # Terminal-based typing test
    ];
  };
}
