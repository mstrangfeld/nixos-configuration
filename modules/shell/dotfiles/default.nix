{ pkgs, ... }: { xdg.configFile."ranger/rc.conf".source = ./ranger.conf; }
