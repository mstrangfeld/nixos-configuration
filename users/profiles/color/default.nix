{ format }:
let
  colordef = code: format + code;
in
rec {
  base00 = colordef "212121";
  base01 = colordef "303030";
  base02 = colordef "353535";
  base03 = colordef "4a4a4a";
  base04 = colordef "b2ccd6";
  base05 = colordef "eeffff";
  base06 = colordef "eeffff";
  base07 = colordef "ffffff";
  base08 = colordef "f07178";
  base09 = colordef "f78c6c";
  base0A = colordef "ffcb6b";
  base0B = colordef "c3e88d";
  base0C = colordef "89ddff";
  base0D = colordef "82aaff";
  base0E = colordef "c792ea";
  base0F = colordef "ff5370";

  foreground = base05;
  background = base00;
  cursorColor = base05;
}
