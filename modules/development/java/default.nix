{ config, lib, pkgs, ... }:

with lib;
let cfg = config.modules.development.java;
in {
  options.modules.development.java.enable = mkEnableOption "Java";

  config = mkIf cfg.enable (mkMerge [
    {
      environment.systemPackages = with pkgs; [
        ant # A Java-based build tool
        gradle # Enterprise-grade build system
        groovy # An agile dynamic language for the Java Platform
        jdk # The open-source Java Development Kit
        kotlin # General purpose programming language
        ktlint # An anti-bikeshedding Kotlin linter with built-in formatter
        maven # Build automation tool (used primarily for Java projects)
      ];
    }

    (mkIf config.modules.desktop.enable {
      environment.systemPackages = with pkgs; [
        # android-studio # The Official IDE for Android
        eclipses.eclipse-java # Eclipse IDE for Java Developers
        jetbrains.idea-community # IDE by Jetbrains
      ];
      home-manager.users.marvin = { pkgs, ... }: {
        programs.vscode.extensions = with pkgs.vscode-extensions; [
          # TODO: Add Java extensions
        ];
      };
    })
  ]);
}
