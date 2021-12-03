{ pkgs, ... }:
{
  environment.pathsToLink = [ "/share/zsh" ];

  users.mutableUsers = true;
  users.users.marvin = {
    uid = 1000;
    description = "Marvin Strangfeld";
    isNormalUser = true;
    initialPassword = "nivram";
    extraGroups = [ "wheel" "networkmanager" "audio" "video" "power" "docker" "dialout" ];
    shell = pkgs.zsh;
  };
}
