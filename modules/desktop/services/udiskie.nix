{ ... }:
{
  # Removable disk automounter for udisks
  services.udiskie = {
    enable = true;
    tray = "always";
  };
}
