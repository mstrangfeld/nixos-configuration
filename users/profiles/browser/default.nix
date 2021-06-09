{ pkgs, ... }:
{
  # Privacy-oriented browser for Desktop and Laptop computers
  programs.brave = {
    enable = true;
    extensions = [
      { id = "nngceckbapebfimnlniiiahkandclblb"; } # Bitwarden Password Manager
    ];
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
    extensions = with pkgs.nur.repos.rycee.firefox-addons; [
      bitwarden
    ];
  };
}
