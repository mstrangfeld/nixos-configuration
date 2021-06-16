let
  colorscheme = import ../color { format = "0x"; };
in
{
  programs.alacritty = {
    enable = true;
    settings = {
      window.startup_mode = "Maximized";
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
      colors = {
        # Default colors
        primary = {
          background = colorscheme.background;
          foreground = colorscheme.foreground;
        };
        # Colors the cursor will use if `custom_cursor_colors` is true
        cursor = {
          text = colorscheme.background;
          cursor = colorscheme.foreground;
        };

        # Normal colors
        normal = {
          black = colorscheme.base00;
          red = colorscheme.base08;
          green = colorscheme.base0B;
          yellow = colorscheme.base0A;
          blue = colorscheme.base0D;
          magenta = colorscheme.base0E;
          cyan = colorscheme.base0C;
          white = colorscheme.base05;
        };

        # Bright colors
        bright = {
          black = colorscheme.base03;
          red = colorscheme.base08;
          green = colorscheme.base0B;
          yellow = colorscheme.base0A;
          blue = colorscheme.base0D;
          magenta = colorscheme.base0E;
          cyan = colorscheme.base0C;
          white = colorscheme.base07;
        };
        indexed_colors = [
          { index = 16; color = colorscheme.base09; }
          { index = 17; color = colorscheme.base0F; }
          { index = 18; color = colorscheme.base01; }
          { index = 19; color = colorscheme.base02; }
          { index = 20; color = colorscheme.base04; }
          { index = 21; color = colorscheme.base05; }
        ];
      };
    };
  };
}
