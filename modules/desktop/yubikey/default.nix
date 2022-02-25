{ config, lib, pkgs, ... }:

with lib;
let cfg = config.modules.desktop.yubikey;
in {
  options.modules.desktop.yubikey.enable = mkEnableOption "YubiKey";

  config = mkIf cfg.enable {
    environment = {
      systemPackages = with pkgs; [
        yubikey-manager # Command line tool for configuring any YubiKey over all USB transports
        yubico-pam # Yubico PAM module
        yubico-piv-tool # Used for interacting with the Privilege and Identification Card (PIV) application on a YubiKey
        yubikey-manager-qt # Cross-platform application for configuring any YubiKey over all USB interfaces
        yubikey-personalization # A library and command line tool to personalize YubiKeys
        yubikey-personalization-gui # A QT based cross-platform utility designed to facilitate reconfiguration of the Yubikey
      ];
    };

    services.udev.packages = with pkgs; [
      yubikey-personalization
    ];

    services.pcscd.enable = true; # Whether to enable PCSC-Lite daemon

    security.pam.u2f = {
      enable = true;
      debug = false;
      cue = true;
    };
  };
}
