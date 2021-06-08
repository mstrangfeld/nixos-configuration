{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # android-studio # The Official IDE for Android
    gradle # Enterprise-grade build system
    jdk # The open-source Java Development Kit
    jetbrains.idea-community # IDE by Jetbrains
    kotlin # General purpose programming language
    ktlint # An anti-bikeshedding Kotlin linter with built-in formatter
  ];

  # Eclipse IDE for Java Developers
  programs.eclipse = {
    enable = true;
  };
}
