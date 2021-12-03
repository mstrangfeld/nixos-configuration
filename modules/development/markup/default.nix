{ pkgs, ... }:
{
  environment = {
    systemPackages = with pkgs; [
      asciidoctor # A faster Asciidoc processor written in Ruby
      pandoc # Conversion between markup formats
      texlive.combined.scheme-full # TeX Live environment for scheme-full
      tikzit # A graphical tool for rapidly creating graphs and diagrams using PGF/TikZ
    ];
  };
}
