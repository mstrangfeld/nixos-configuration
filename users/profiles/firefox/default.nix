{
  programs.firefox = {
    enable = true;
    profiles = {
      marvin = {
        settings = {
          "general.smoothScroll" = false;
        };
      };
    };
  };
}
