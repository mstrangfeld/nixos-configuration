{ pkgs, ... }:
{
  environment = {
    systemPackages = with pkgs; [
      # android-studio # The Official IDE for Android
      ant # A Java-based build tool
      eclipses.eclipse-java # Eclipse IDE for Java Developers
      gradle # Enterprise-grade build system
      groovy # An agile dynamic language for the Java Platform
      jdk # The open-source Java Development Kit
      kotlin # General purpose programming language
      ktlint # An anti-bikeshedding Kotlin linter with built-in formatter
      maven # Build automation tool (used primarily for Java projects)
    ];
  };
}
