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
      rr # Records nondeterministic executions and debugs them deterministically
      unzip # An extraction utility for archives compressed in .zip format
    ];

    services.gpg-agent = {
      enable = true;
      defaultCacheTtl = 1800;
      enableSshSupport = true;
    };

    services.kdeconnect = {
      enable = true;
      indicator = true;
    };
  };

  users.users.marvin = {
    uid = 1000;
    password = "marvin";
    description = "Marvin Strangfeld";
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "audio" "power" "docker" ];
    shell = pkgs.zsh;
  };
}
