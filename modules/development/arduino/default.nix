{ pkgs, ... }:
{
  environment = {
    systemPackages = with pkgs; [
      arduino # Open-source electronics prototyping platform
      arduino-cli # Arduino from the command line
      arduino-core # Open-source electronics prototyping platform
      platformio # An open source ecosystem for IoT development
    ];
  };
}
