{ options, config, lib, pkgs, ... }:

with lib;
let cfg = config.modules.development.arduino;
in {
  options.modules.development.arduino.enable = mkEnableOption "Arduino";

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      arduino # Open-source electronics prototyping platform
      arduino-cli # Arduino from the command line
      arduino-core # Open-source electronics prototyping platform
      platformio # An open source ecosystem for IoT development
    ];
  };
}
