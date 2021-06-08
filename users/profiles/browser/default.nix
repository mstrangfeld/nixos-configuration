{
  # Privacy-oriented browser for Desktop and Laptop computers
  programs.brave = {
    enable = true;
  };

  # A web browser built from Firefox source tree
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
