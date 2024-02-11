{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.modules.desktop.browser;
  desktop-entries = {
    "brave" = "brave-browser.desktop";
    "firefox" = "firefox.desktop";
  };
in
{
  imports = [ ./brave.nix ./firefox.nix ];

  options.modules.desktop.browser = {
    default = mkOption {
      default = "brave";
      type = types.nullOr types.str;
    };
  };

  config = mkIf (cfg.default != null) {
    environment.variables.BROWSER = cfg.default;

    home-manager.users.marvin = { pkgs, ... }: {
      xdg.mimeApps =
        let app = desktop-entries.${cfg.default};
        in {
          enable = true;
          defaultApplications = {
            "text/html" = [ app ];
            "text/xml" = [ app ];
            "application/xhtml_xml" = [ app ];
            "image/webp" = [ app ];
            "x-scheme-handler/http" = [ app ];
            "x-scheme-handler/https" = [ app ];
            "x-scheme-handler/ftp" = [ app ];
          };
          associations.added = {
            "text/html" = [ app ];
            "text/xml" = [ app ];
            "application/xhtml_xml" = [ app ];
            "image/webp" = [ app ];
            "x-scheme-handler/https" = [ app ];
            "x-scheme-handler/ftp" = [ app ];
          };
        };
    };
  };
}
