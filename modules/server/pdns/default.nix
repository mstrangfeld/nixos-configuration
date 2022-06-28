{ config, lib, pkgs, ... }:

with lib;
let cfg = config.modules.server.pdns;
in {
  options.modules.server.pdns.enable = mkEnableOption "Server";

  config = mkIf cfg.enable {
    networking.firewall.interfaces."tailscale0" = {
      allowedUDPPorts = [ 53 ];
      allowedTCPPorts = [ 53 ];
    };

    services.pdns-recursor = {
      enable = true;
      dns.address = [ "100.114.143.32" ];
      dns.port = 53;
      dns.allowFrom = [ "100.64.0.0/10" ];
      api.address = "100.114.143.32";
    };
  };
}
