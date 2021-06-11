{ pkgs, ... }:
{
  environment = {
    systemPackages = with pkgs; [
      cadence # Collection of tools useful for audio production
      patchage # Modular patch bay for Jack and ALSA systems
      qjackctl # A Qt application to control the JACK sound server daemon
      zita-njbridge # command line Jack clients to transmit full quality multichannel audio over a local IP network
    ];
  };

  hardware.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  security.rtkit.enable = true;

  # See: https://jackaudio.org/faq/linux_rt_config.html

  users.groups = {
    audio = { };
  };

  security.pam.loginLimits = [
    {
      domain = "@audio";
      item = "rtprio";
      type = "-";
      value = "95";
    }
    {
      domain = "@audio";
      item = "memlock";
      type = "-";
      value = "unlimited";
    }
  ];
}
