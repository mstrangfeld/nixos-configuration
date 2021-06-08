{ pkgs, ... }:
{
  home.packages = with pkgs; [
    minecraft # Official launcher for Minecraft, a sandbox-building game
    vlc # Cross-platform media player and streaming server
    spotify # Play music from the Spotify music service
    spotify-tui # Spotify for the terminal written in Rust
    steam # A digital distribution platform
  ];
}
