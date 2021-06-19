{ pkgs, ... }:
{
  # Window switcher, run dialog and dmenu replacement
  programs.rofi = {
    enable = true;
    terminal = "${pkgs.alacritty}/bin/alacritty";
    font = "FiraCode Nerd Font 16";
    location = "center";
    padding = 10;
    lines = 10;
  };
}
