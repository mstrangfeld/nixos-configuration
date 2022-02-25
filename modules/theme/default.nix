{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.modules.theme;
  hexColor = code: "0x" + code;
in {
  options.modules.theme = {
    enable = mkEnableOption "Theme";
    colors = {
      base00 = mkOption { default = "212121"; };
      base01 = mkOption { default = "303030"; };
      base02 = mkOption { default = "353535"; };
      base03 = mkOption { default = "4a4a4a"; };
      base04 = mkOption { default = "b2ccd6"; };
      base05 = mkOption { default = "eeffff"; };
      base06 = mkOption { default = "eeffff"; };
      base07 = mkOption { default = "ffffff"; };
      base08 = mkOption { default = "f07178"; };
      base09 = mkOption { default = "f78c6c"; };
      base0A = mkOption { default = "ffcb6b"; };
      base0B = mkOption { default = "c3e88d"; };
      base0C = mkOption { default = "89ddff"; };
      base0D = mkOption { default = "82aaff"; };
      base0E = mkOption { default = "c792ea"; };
      base0F = mkOption { default = "ff5370"; };

      foreground = mkOption { default = cfg.colors.base05; };
      background = mkOption { default = cfg.colors.base00; };
      cursorColor = mkOption { default = cfg.colors.base05; };
    };
  };

  config = mkIf cfg.enable {

    fonts = {
      fonts = with pkgs; [
        fira # Mozilla's new typeface, used in Firefox OS
        fira-code # Monospace font with programming ligatures
        fira-code-symbols # FiraCode unicode ligature glyphs in private use area
        fira-mono # Monospace font for Firefox OS
        # hack-font # A typeface designed for source code
        powerline-fonts
        powerline-symbols
        # roboto # The Roboto family of fonts
        # roboto-mono # Google Roboto Mono fonts
        # source-code-pro # A set of monospaced OpenType fonts designed for coding environments
        (nerdfonts.override {
          fonts = [
            "FiraCode"
            # "FiraMono"
            # "Hack"
            # "RobotoMono"
            # "SourceCodePro"
          ];
        }) # Iconic font aggregator, collection, & patcher. 3,600+ icons, 50+ patched fonts
      ];
      fontconfig.defaultFonts = {
        monospace = [ "FiraCode Nerd Font" ];
        sansSerif = [ "Fira Sans" ];
      };
    };

    home-manager.users.marvin = { pkgs, ... }: {
      programs.alacritty.settings = {
        font = {
          normal = {
            family = "FiraCode Nerd Font";
            style = "Regular";
          };
          bold = {
            family = "FiraCode Nerd Font";
            style = "Bold";
          };
          italic = {
            family = "FiraCode Nerd Font";
            style = "Italic";
          };
        };
        colors = with cfg.colors; {
          # Default colors
          primary = {
            background = hexColor background;
            foreground = hexColor foreground;
          };
          # Colors the cursor will use if `custom_cursor_colors` is true
          cursor = {
            text = hexColor background;
            cursor = hexColor foreground;
          };
          # Normal colors
          normal = {
            black = hexColor base00;
            red = hexColor base08;
            green = hexColor base0B;
            yellow = hexColor base0A;
            blue = hexColor base0D;
            magenta = hexColor base0E;
            cyan = hexColor base0C;
            white = hexColor base05;
          };
          # Bright colors
          bright = {
            black = hexColor base03;
            red = hexColor base08;
            green = hexColor base0B;
            yellow = hexColor base0A;
            blue = hexColor base0D;
            magenta = hexColor base0E;
            cyan = hexColor base0C;
            white = hexColor base07;
          };
          indexed_colors = [
            { index = 16; color = hexColor base09; }
            { index = 17; color = hexColor base0F; }
            { index = 18; color = hexColor base01; }
            { index = 19; color = hexColor base02; }
            { index = 20; color = hexColor base04; }
            { index = 21; color = hexColor base05; }
          ];
        };
      };
    };
  };
}
