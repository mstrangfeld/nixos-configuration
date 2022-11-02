{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.modules.theme;
  hexColor = code: "#" + code;
in {
  options.modules.theme = {
    enable = mkEnableOption "Theme";
    colors = {
      hex = mkOption { default = hexColor; };
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
        powerline-fonts
        powerline-symbols
        source-code-pro # A set of monospaced OpenType fonts designed for coding environments
        (nerdfonts.override {
          fonts = [ "FiraCode" "FiraMono" "SourceCodePro" ];
        }) # Iconic font aggregator, collection, & patcher. 3,600+ icons, 50+ patched fonts
      ];
      fontconfig.defaultFonts = {
        monospace = [ "FiraCode Nerd Font" ];
        sansSerif = [ "Fira Sans" ];
      };
    };

    home-manager.users.marvin = { pkgs, config, ... }: {
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

      home.pointerCursor = {
        package = pkgs.quintom-cursor-theme;
        name = "Quintom_Ink";
        x11.enable = true;
        x11.defaultCursor = "left_ptr";
      };

      xresources.properties = with cfg.colors; {
        "*foreground" = hex foreground;
        "*background" = hex background;
        "*cursorColor" = hex cursorColor;

        "*color0" = hex base00;
        "*color1" = hex base08;
        "*color2" = hex base0B;
        "*color3" = hex base0A;
        "*color4" = hex base0D;
        "*color5" = hex base0E;
        "*color6" = hex base0C;
        "*color7" = hex base05;

        "*color8" = hex base03;
        "*color9" = hex base08;
        "*color10" = hex base0B;
        "*color11" = hex base0A;
        "*color12" = hex base0D;
        "*color13" = hex base0E;
        "*color14" = hex base0C;
        "*color15" = hex base07;

        "*color16" = hex base09;
        "*color17" = hex base0F;
        "*color18" = hex base01;
        "*color19" = hex base02;
        "*color20" = hex base04;
        "*color21" = hex base06;
      };

      programs.rofi = {
        terminal = "${pkgs.alacritty}/bin/alacritty";
        font = "FiraCode Nerd Font 20";
        location = "center";
        theme = with cfg.colors;
          let
            inherit (config.lib.formats.rasi) mkLiteral;
            red = mkLiteral (hex base08);
            blue = mkLiteral (hex base0D);
            lightfg = mkLiteral (hex base06);
            lightbg = mkLiteral (hex base01);
            foreground = mkLiteral (hex base05);
            background = mkLiteral (hex base00);
            mkElementConfig = bg: fg: {
              background-color = bg;
              text-color = fg;
            };
          in with cfg.colors; rec {
            "*" = {
              background-color = background;
              border-color = foreground;
            };
            window = {
              background-color = background;
              border = 1;
              padding = 5;
            };
            mainbox = {
              border = 0;
              padding = 0;
            };
            message = {
              border = mkLiteral "1px dash 0px 0px";
              border-color = foreground;
              padding = mkLiteral "1px";
            };
            textbox = { text-color = foreground; };
            listview = {
              fixed-height = 0;
              border = mkLiteral "2px dash 0px 0px";
              boder-color = foreground;
              spacing = mkLiteral "2px";
              scrollbar = true;
              padding = mkLiteral "2px 0px 0px";
            };
            "element-text, element-icon" = {
              background-color = mkLiteral "inherit";
              text-color = mkLiteral "inherit";
            };
            element = {
              border = 0;
              padding = mkLiteral "1px";
            };

            "element normal.normal" = mkElementConfig background foreground;
            "element normal.urgent" = mkElementConfig background red;
            "element normal.active" = mkElementConfig background blue;
            "element alternate.normal" = mkElementConfig background foreground;
            "element alternate.urgent" = mkElementConfig background red;
            "element alternate.active" = mkElementConfig background blue;
            "element selected.normal" = mkElementConfig lightbg lightfg;
            "element selected.urgent" = mkElementConfig red background;
            "element selected.active" = mkElementConfig blue background;

            scrollbar = {
              width = mkLiteral "4px";
              border = 0;
              handle-color = foreground;
              handle-width = mkLiteral "8px";
              padding = 0;
            };
            sidebar = {
              border = mkLiteral "2px dash 0px 0px";
              boder-color = foreground;
            };
            button = {
              spacing = 0;
              text-color = foreground;
            };
            "button selected" = {
              background-color = lightfg;
              text-color = lightbg;
            };
            inputbar = {
              spacing = mkLiteral "0px";
              text-color = foreground;
              padding = mkLiteral "1px";
              children = mkLiteral
                "[ prompt,textbox-prompt-colon,entry,case-indicator ]";
            };
            case-indicator = {
              spacing = 0;
              text-color = foreground;
            };
            entry = {
              spacing = 0;
              text-color = foreground;
            };
            prompt = {
              spacing = 0;
              text-color = foreground;
            };
            textbox-prompt-colon = {
              expand = false;
              str = ":";
              margin = mkLiteral "0px 0.3000em 0.000em 0.000em";
              text-color = mkLiteral "inherit";
            };
          };
      };

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
            background = hex background;
            foreground = hex foreground;
          };
          # Colors the cursor will use if `custom_cursor_colors` is true
          cursor = {
            text = hex background;
            cursor = hex foreground;
          };
          # Normal colors
          normal = {
            black = hex base00;
            red = hex base08;
            green = hex base0B;
            yellow = hex base0A;
            blue = hex base0D;
            magenta = hex base0E;
            cyan = hex base0C;
            white = hex base05;
          };
          # Bright colors
          bright = {
            black = hex base03;
            red = hex base08;
            green = hex base0B;
            yellow = hex base0A;
            blue = hex base0D;
            magenta = hex base0E;
            cyan = hex base0C;
            white = hex base07;
          };
          indexed_colors = [
            {
              index = 16;
              color = hex base09;
            }
            {
              index = 17;
              color = hex base0F;
            }
            {
              index = 18;
              color = hex base01;
            }
            {
              index = 19;
              color = hex base02;
            }
            {
              index = 20;
              color = hex base04;
            }
            {
              index = 21;
              color = hex base05;
            }
          ];
        };
      };
      services.dunst = with cfg.colors; {
        iconTheme = {
          name = "Tela";
          package = pkgs.tela-icon-theme;
          size = "16x16";
        };
        settings = {
          global = {
            transparency = 10;
            padding = 16;
            horizontal_padding = 16;
            frame_width = 3;
            frame_color = hex base00;
            separator_color = "frame";
            font = "FiraCode Nerd Font 10";
            line_height = 4;
            alignment = "left";
            vertical_alignment = "center";
            icon_position = "left";
            word_wrap = "yes";
            ignore_newline = "no";
            show_indicators = "yes";
            sort = true;
            stack_duplicates = true;
            startup_notification = false;
            hide_duplicate_count = true;
          };
          urgency_low = {
            background = hex base00;
            forefround = hex base05;
          };
          urgency_normal = {
            background = hex base00;
            forefround = hex base05;
          };
          urgency_critical = {
            background = hex base0A;
            forefrond = hex base0D;
            frame_color = hex base08;
          };
        };
      };
    };
  };
}
