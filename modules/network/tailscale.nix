{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.modules.network.tailscale;
in {
  options.modules.network.tailscale = {
    enable = mkEnableOption "Tailscale";
  };

  config = mkIf cfg.enable {
    services.tailscale = {
      enable = true;
    };
  };
}
