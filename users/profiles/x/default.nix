{ ... }:
let
  colorscheme = import ../color { format = "#"; };
in
{

  imports = [
    ./services/dunst.nix
    ./services/grobi.nix
    ./services/networkmanager.nix
    ./services/picom.nix
    ./services/polybar.nix
    ./services/rofi.nix
    ./services/screenlocker.nix
    ./services/udiskie.nix

    ./xmonad
  ];

  xresources.properties = {
    "*foreground" = colorscheme.foreground;
    "*background" = colorscheme.background;
    "*cursorColor" = colorscheme.cursorColor;

    "*color0" = colorscheme.base00;
    "*color1" = colorscheme.base08;
    "*color2" = colorscheme.base0B;
    "*color3" = colorscheme.base0A;
    "*color4" = colorscheme.base0D;
    "*color5" = colorscheme.base0E;
    "*color6" = colorscheme.base0C;
    "*color7" = colorscheme.base05;

    "*color8" = colorscheme.base03;
    "*color9" = colorscheme.base08;
    "*color10" = colorscheme.base0B;
    "*color11" = colorscheme.base0A;
    "*color12" = colorscheme.base0D;
    "*color13" = colorscheme.base0E;
    "*color14" = colorscheme.base0C;
    "*color15" = colorscheme.base07;

    "*color16" = colorscheme.base09;
    "*color17" = colorscheme.base0F;
    "*color18" = colorscheme.base01;
    "*color19" = colorscheme.base02;
    "*color20" = colorscheme.base04;
    "*color21" = colorscheme.base06;
  };
}
