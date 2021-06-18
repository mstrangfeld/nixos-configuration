{ pkgs, ... }:
{
  home.packages = with pkgs; [
    networkmanager_dmenu # Small script to manage NetworkManager connections with dmenu instead of nm-applet
  ];

  xdg.configFile."networkmanager-dmenu/config.ini".text = ''
    [dmenu]
    dmenu_command = rofi
    rofi_highlight = True
    [editor]
    gui_if_available = True
  '';

  services.network-manager-applet.enable = true;
}
