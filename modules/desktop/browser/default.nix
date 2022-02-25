{ config, lib, pkgs, ... }:

with lib;
let cfg = config.modules.desktop.browser;
in {
  imports = [
    ./brave.nix
    ./firefox.nix
  ];

  options.modules.desktop.browser = {
    default = mkOption {
      default = "brave";
      type = types.nullOr types.str;
    };
  };

  config = mkIf (cfg.default != null) {
    env.BROWSER = cfg.default;
  };
}
