{ config, lib, pkgs, ... }:

with lib;
let cfg = config.modules.development.javascript;
in {
  options.modules.development.javascript.enable = mkEnableOption "JavaScript";

  config = mkIf cfg.enable (mkMerge [
    {
      environment.systemPackages = with pkgs; [
        nodejs # Event-driven I/O framework for the V8 JavaScript engine
        nodePackages.npm # a package manager for JavaScript
        yarn # Fast, reliable, and secure dependency management for javascript
      ];
    }
  ]);
}
