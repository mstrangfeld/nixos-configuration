{ config, pkgs, ... }:
{
  home-manager.users.marvin = { suites, ... }: {
    imports = suites.workstation;

    home.packages = with pkgs; [
      bitwarden-cli # Bitwarden password manager cli
      borgbackup # Deduplicating archiver / backup tool
      demoit # Live coding demos
      exercism # A Go based command line tool for exercism.io
      patchage # Modular patch bay for Jack and ALSA systems
      qjackctl # A Qt application to control the JACK sound server daemon
      zita-njbridge # command line Jack clients to transmit full quality multichannel audio over a local IP network
      rr # Records nondeterministic executions and debugs them deterministically
      tmux # Terminal multiplexer
      unzip # An extraction utility for archives compressed in .zip format
    ];
  };

  users.users.marvin = {
    uid = 1000;
    password = "marvin";
    description = "Marvin Strangfeld";
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "audio" "power" "docker" ];
    shell = pkgs.zsh;
  };

  services.gpg.agent = {
    enable = true;
    defaultCacheTtl = 1800;
    enableSshSupport = true;
  };
}
