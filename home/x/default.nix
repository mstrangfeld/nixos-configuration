{ pkgs, ... }:
let
  colorscheme = import ../color { format = "#"; };
in
{

  imports = [
    ./services/autorandr.nix
    ./services/dunst.nix
    ./services/networkmanager.nix
    ./services/picom.nix
    ./services/polybar
    ./services/rofi
    ./services/screenlocker.nix
    ./services/udiskie.nix

    ./xmonad
  ];

  home.keyboard = {
    layout = "de";
    options = [
      "eurosign:e"
    ];
  };

  # fonts.fontconfig.enable = true;

  gtk = {
    enable = true;
    font = {
      package = pkgs.fira;
      name = "Fira Sans";
    };
    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus";
    };
    theme = {
      package = pkgs.materia-theme;
      name = "Materia-dark";
    };
  };

  xsession.pointerCursor = {
    package = pkgs.quintom-cursor-theme;
    defaultCursor = "left_ptr";
    name = "Quintom_Ink";
  };

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

  xdg.mime.enable = true;
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = [ "brave-browser.desktop" ];
      "text/xml" = [ "brave-browser.desktop" ];
      "application/xhtml_xml" = [ "brave-browser.desktop" ];
      "image/webp" = [ "brave-browser.desktop" ];
      "x-scheme-handler/http" = [ "brave-browser.desktop" ];
      "x-scheme-handler/https" = [ "brave-browser.desktop" ];
      "x-scheme-handler/ftp" = [ "brave-browser.desktop" ];
    };
    associations.added = {
      "text/html" = [ "brave-browser.desktop" ];
      "text/xml" = [ "brave-browser.desktop" ];
      "application/xhtml_xml" = [ "brave-browser.desktop" ];
      "image/webp" = [ "brave-browser.desktop" ];
      "x-scheme-handler/https" = [ "brave-browser.desktop" ];
      "x-scheme-handler/ftp" = [ "brave-browser.desktop" ];
    };
  };
}
