self: super:
{
  mixxx-udev = super.mixxx.overrideAttrs (old: {
    dontBuild = true;
    dontConfigure = true;
    installPhase = ''
      mkdir -p $out/lib/udev/rules.d
      cp res/linux/mixxx.usb.rules $out/lib/udev/rules.d/mixxx.usb.rules
    '';
  });
}