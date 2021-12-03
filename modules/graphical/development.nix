{ pkgs, ... }:
{
  environment = {
    systemPackages = with pkgs; [
      jetbrains.idea-community # IDE by Jetbrains
    ];
  };
}
