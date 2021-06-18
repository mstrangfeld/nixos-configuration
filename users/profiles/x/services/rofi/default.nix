{ pkgs, ... }:
{
  # Window switcher, run dialog and dmenu replacement
  programs.rofi = {
    enable = true;
    terminal = "${pkgs.alacritty}/bin/alacritty";
    font = "Fira Code Nerd Font";
    location = "center";
    padding = 10;
    lines = 10;
    colors = { };
  };
}
