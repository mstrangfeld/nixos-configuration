{ pkgs, ... }:
{
  environment = {
    systemPackages = with pkgs; [
      discord # All-in-one cross-platform voice and text chat for gamers
      # element-desktop # A feature-rich client for Matrix.org
      # TODO: Rocket.Chat
      signal-desktop # Private, simple, and secure messenger
      tdesktop # Telegram Desktop messaging app
      # weechat # A fast, light and extensible chat client
      zoom-us # zoom.us video conferencing application
    ];
  };
}
