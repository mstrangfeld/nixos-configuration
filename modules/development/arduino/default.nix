{ pkgs, ... }:
{
  environment = {
    systemPackages = with pkgs; [
      arduino # Open-source electronics prototyping platform
      arduino-cli # Arduino from the command line
      arduino-core # Open-source electronics prototyping platform
      ino # Command line toolkit for working with Arduino hardware
      platformio # An open source ecosystem for IoT development
    ];
  };
}
