{ config, pkgs, ... }:
{
  home-manager.users.marvin = { suites, ... }: {
    imports = suites.workstation;

    home.packages = with pkgs; [
      bitwarden-cli # Bitwarden password manager cli
      borgbackup # Deduplicating archiver / backup tool
      demoit # Live coding demos
      rr # Records nondeterministic executions and debugs them deterministically
      spotify # Play music from the Spotify music service
      spotify-tui # Spotify for the terminal written in Rust
      weechat # A fast, light and extensible chat client
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
}
