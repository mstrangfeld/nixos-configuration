{ ... }:
{
  # Window switcher, run dialog and dmenu replacement
  programs.rofi = {
    enable = true;
    terminal = "${pkgs.alacritty}/bin/alacritty";
    theme = ./theme.rafi;
  };
}
