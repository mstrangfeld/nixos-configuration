{ ... }:
{
  services.picom = {
    enable = true;
    inactiveOpacity = "0.9";
    backend = "glx";
    # https://github.com/yshui/picom/issues/375#issuecomment-635439374
    experimentalBackends = true;
    opacityRule = [ "100:name *= 'i3lock'" ];
    # https://wiki.archlinux.org/title/Picom#Flicker
    extraOptions = ''
      xrender-sync-fence = true;
      unredir-if-possible = false;
    '';
    # https://wiki.archlinux.org/title/Picom#Lag_with_Nvidia_proprietary_drivers_and_FullCompositionPipeline
    vSync = true;
  };
}
