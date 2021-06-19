{ pkgs, ... }:
let
  colorscheme = import ../../color { format = "#"; };
in
{
  services.dunst = {
    enable = true;
    iconTheme = {
      name = "Tela";
      package = pkgs.tela-icon-theme;
      size = "16x16";
    };
    settings = {
      global = {
        monitor = 0;
        geometry = "600x50-50+65";
        shrink = "yes";
        transparency = 10;
        padding = 16;
        horizontal_padding = 16;
        frame_width = 3;
        frame_color = colorscheme.base00;
        separator_color = "frame";
        font = "FiraCode Nerd Font 10";
        line_height = 4;
        idle_threshold = 120;
        markup = "full";
        format = ''<b>%s</b>\n%b'';
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
        background = colorscheme.base00;
        forefround = colorscheme.base05;
        timeout = 4;
      };
      urgency_normal = {
        background = colorscheme.base00;
        forefround = colorscheme.base05;
        timeout = 4;
      };
      urgency_critical = {
        background = colorscheme.base0A;
        forefrond = colorscheme.base0D;
        frame_color = colorscheme.base08;
        timeout = 10;
      };
    };
  };
}
