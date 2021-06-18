{ pkgs, ... }:
{
  xsession = {
    enable = true;

    initExtra = extra + polybarOpts;

    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
      extraPackages = with pkgs.haskellPackages; [
        dbus
        monad-logger
      ];
      config = ./config.hs;
    };
  };
}
