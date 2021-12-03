final: prev:
{
  mixxx-udev = prev.mixxx.overrideAttrs (old: {
    dontBuild = true;
    dontConfigure = true;
    installPhase = ''
      mkdir -p $out/lib/udev/rules.d
      cp res/linux/mixxx-usb-uaccess.rules $out/lib/udev/rules.d/mixxx-usb-uaccess.rules
    '';
  });

  gopro-webcam = prev.callPackage ./gopro-webcam { };
}
