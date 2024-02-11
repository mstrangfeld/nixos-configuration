{ pkgs, ... }:
let
  fancywatsonstatus = pkgs.writeScriptBin "fancywatsonstatus"
    (builtins.readFile ./fancywatsonstatus);
  fkill = pkgs.writeScriptBin "fkill" (builtins.readFile ./fkill);
  jenkinscli =
    pkgs.writeScriptBin "jenkinscli" (builtins.readFile ./jenkinscli);
  open = pkgs.writeScriptBin "open" (builtins.readFile ./open);
  oxtop = pkgs.writeScriptBin "oxtop" (builtins.readFile ./oxtop);
  restart-kwin =
    pkgs.writeScriptBin "restart-kwin" (builtins.readFile ./restart-kwin);
  restart-plasma =
    pkgs.writeScriptBin "restart-plasma" (builtins.readFile ./restart-plasma);
  tm = pkgs.writeScriptBin "tm" (builtins.readFile ./tm);
  uptimetmux =
    pkgs.writeScriptBin "uptimetmux" (builtins.readFile ./uptimetmux);
in
{
  home.packages = [
    fancywatsonstatus
    fkill
    jenkinscli
    open
    oxtop
    restart-kwin
    restart-plasma
    tm
    uptimetmux
  ];
}
