# A web browser built from Firefox source tree
{ config, lib, pkgs, ... }:

with lib;
let cfg = config.modules.desktop.browser.firefox;
in {
  options.modules.desktop.browser.firefox = {
    enable = mkEnableOption "Firefox Browser";
  };

  config = mkIf cfg.enable {
    home-manager.users.marvin = { pkgs, ... }: {
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
    };
  };
}
