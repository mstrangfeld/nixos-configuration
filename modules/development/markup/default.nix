{ config, lib, pkgs, ... }:

with lib;
let cfg = config.modules.development.markup;
in {
  options.modules.development.markup.enable = mkEnableOption "Markup";

  config = mkIf cfg.enable (mkMerge [
    {
      environment.systemPackages = with pkgs; [
        asciidoctor # A faster Asciidoc processor written in Ruby
        pandoc # Conversion between markup formats
        texlive.combined.scheme-full # TeX Live environment for scheme-full
        tikzit # A graphical tool for rapidly creating graphs and diagrams using PGF/TikZ
      ];
    }

    (mkIf config.modules.desktop.enable {
      home-manager.users.marvin = { pkgs, ... }: {
        programs.vscode.extensions = with pkgs.vscode-extensions;
          [ james-yu.latex-workshop ];
      };
    })
  ]);
}
