{ config, lib, pkgs, ... }:
{
  # Configure zsh as an interactive shell
  programs.zsh.enable = true;
  environment.pathsToLink = [ "/share/zsh" ]; # To enable zsh autocomplete

  users.mutableUsers = true;
  users.users.marvin = {
    uid = 1000;
    description = "Marvin Strangfeld";
    isNormalUser = true;
    initialPassword = "nivram";
    extraGroups = [ "wheel" "networkmanager" "audio" "video" "power" "docker" "dialout" "adbusers" ];
    shell = pkgs.zsh;
  };

  users.users.root = {
    initialPassword = "toor";
    shell = pkgs.zsh;
  };

  nix.settings = {
    allowed-users = [ "@wheel" ];
    trusted-users = [ "root" "@wheel" ];
  };
}
