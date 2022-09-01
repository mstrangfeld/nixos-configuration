{ config, lib, pkgs, ... }: {
  # Configure zsh as an interactive shell
  programs.zsh.enable = true;
  environment.pathsToLink = [ "/share/zsh" ]; # To enable zsh autocomplete

  users.mutableUsers = true;
  users.users.marvin = {
    uid = 1000;
    description = "Marvin Strangfeld";
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "audio"
      "rtkit"
      "video"
      "power"
      "docker"
      "dialout"
      "adbusers"
      "libvirtd"
    ];
    shell = pkgs.zsh;
  };

  users.users.root = { shell = pkgs.zsh; };
}
