{ pkgs, ... }: {
  services.dunst = {
    enable = true;
    settings = {
      global = {
        geometry = "600x50-50+65";
        shrink = "yes";
        idle_threshold = 120;
        markup = "full";
        format = "<b>%s</b>\\n%b";
      };
      urgency_low = { timeout = 4; };
      urgency_normal = { timeout = 4; };
      urgency_critical = { timeout = 10; };
    };
  };
}
