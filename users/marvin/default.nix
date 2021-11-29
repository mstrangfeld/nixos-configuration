{ config, pkgs, ... }:
{
  home-manager.users.marvin = { suites, ... }: {
    imports = suites.workstation;

    home.packages = with pkgs; [
      bitwarden-cli # Bitwarden password manager cli
      borgbackup # Deduplicating archiver / backup tool
      demoit # Live coding demos
      droidcam # Linux client for DroidCam app
      exercism # A Go based command line tool for exercism.io
      pcloud # Secure and simple to use cloud storage for your files; pCloud Drive, Electron Edition
    ];

    programs.gpg = {
      enable = true;
    };

    services.gpg-agent = {
      enable = true;
      defaultCacheTtl = 1800;
      enableSshSupport = true;
    };

    services.keybase.enable = true;

    services.kdeconnect = {
      enable = true;
      indicator = true;
    };

    xdg = {
      enable = true;
      userDirs = {
        enable = true;
        createDirectories = true;
      };
    };

    programs.ssh = {
      enable = true;
      matchBlocks = {
        "*.cloud.oxoe.io" = {
          checkHostIP = false;
          extraOptions = {
            StrictHostKeyChecking = "no";
          };
        };
      };
    };
  };

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
