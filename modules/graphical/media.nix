{ pkgs, ... }:
let
  spotify-4k = pkgs.spotify.override { deviceScaleFactor = 1.5; };
in
{
  environment = {
    systemPackages = with pkgs; [
      vlc # Cross-platform media player and streaming server
      spotify-4k # Play music from the Spotify music service
      # spotify-tui # Spotify for the terminal written in Rust
    ];
  };
}
