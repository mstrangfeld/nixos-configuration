{ pkgs, ... }:
{
  environment = {
    systemPackages = with pkgs; [
      arduino # Open-source electronics prototyping platform
      arduino-cli # Arduino from the command line
      ino # Command line toolkit for working with Arduino hardware
    ];
  };
}
