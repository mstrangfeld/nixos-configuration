{ config, lib, pkgs, ... }:

with lib;
let cfg = config.modules.network;
in {

  imports = [
    ./syncthing.nix
    ./tailscale.nix
  ];

  options.modules.network.enable = mkEnableOption "Network";

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      openvpn
      networkmanager-openvpn
    ];

    networking.networkmanager.enable = true;

    services.gnome.gnome-keyring.enable = true;
    security.pam.services.lightdm.enableGnomeKeyring = true;
    programs.ssh.startAgent = false;
  };
}
