{ config, pkgs, ... }:
{
  home-manager.users.marvin = { suites, ... }: {
    imports = suites.workstation;
  };

  users.users.marvin = {
    uid = 1000;
    password = "marvin";
    description = "Marvin Strangfeld";
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "audio" "power" ];
    shell = pkgs.zsh;
  };
}
