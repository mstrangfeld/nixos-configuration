{ pkgs, ... }:
{
  environment = {
    systemPackages = with pkgs; [
      # android-studio # The Official IDE for Android
      gradle # Enterprise-grade build system
      jdk # The open-source Java Development Kit
      kotlin # General purpose programming language
      ktlint # An anti-bikeshedding Kotlin linter with built-in formatter
    ];
  };
}
