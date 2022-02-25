# Privacy-oriented browser for Desktop and Laptop computers
{ config, lib, pkgs, ... }:

with lib;
let cfg = config.modules.desktop.browser.brave;
in {
  options.modules.desktop.browser.brave = {
    enable = mkEnableOption "Brave Browser";
  };

  config = mkIf cfg.enable {
    home-manager.users.marvin = { pkgs, ... }: {
      programs.brave = {
        enable = true;
        extensions = [
          { id = "nngceckbapebfimnlniiiahkandclblb"; } # Bitwarden Password Manager
          { id = "occjjkgifpmdgodlplnacmkejpdionan"; } # AutoScroll
        ];
      };
    };
  };
}
