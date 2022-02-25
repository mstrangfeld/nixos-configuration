{ options, config, lib, pkgs, ... }:

with lib;
let
  cfg = config.modules.desktop;
  spotify-4k = pkgs.spotify.override { deviceScaleFactor = 1.5; };
in {
  imports = [
    ./audio
    ./browser
    ./creative
    ./games
    ./wm
    ./yubikey
  ];

  options.modules.desktop = {
    enable = mkEnableOption "Desktop";
  };

  config = mkIf cfg.enable {
    environment = {
      systemPackages = with pkgs; [
        # Communication
        discord # All-in-one cross-platform voice and text chat for gamers
        gopro-webcam
        # TODO: Rocket.Chat
        signal-desktop # Private, simple, and secure messenger
        zoom-us # zoom.us video conferencing application

        # Media Applications
        vlc # Cross-platform media player and streaming server
        spotify-4k # Play music from the Spotify music service
      ];
    };
    home-manager.users.marvin = { pkgs, ... }: {
      programs.alacritty = {
        enable = true;
        settings = {
          window.startup_mode = "Maximized";
        };
      };
    };
  };
}
