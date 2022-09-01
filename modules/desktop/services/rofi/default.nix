{ pkgs, config, ... }: {
  # Window switcher, run dialog and dmenu replacement
  programs.rofi = {
    enable = true;
    terminal = "${pkgs.alacritty}/bin/alacritty";
    font = "FiraCode Nerd Font 16";
    location = "center";
    theme = let inherit (config.lib.formats.rasi) mkLiteral;
    in {
      "*" = {
        padding = 10;
        lines = 10;
      };
    };
  };
}
