{ pkgs, ... }:
{
  environment = {
    systemPackages = with pkgs; [
      blender # 3D Creation/Animation/Publishing System
      # darktable # Virtual lighttable and darkroom for photographers
      gimp # The GNU Image Manipulation Program
      # inkscape # Vector graphics editor
      # krita # A free and open source painting application
      # natron # Node-graph based, open-source compositing software
      obs-studio # Free and open source software for video recording and live streaming
      # rawtherapee # RAW converter and digital photo processing software
      # shotcut # A free, open source, cross-platform video editor
    ];
  };
}
