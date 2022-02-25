{ config, lib, pkgs, ... }:

with lib;
let cfg = config.modules.shell;
in {
  options.modules.shell.enable = mkEnableOption "Shell";

  config = mkIf cfg.enable {

  };
}
