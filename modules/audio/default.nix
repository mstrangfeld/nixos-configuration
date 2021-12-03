{ pkgs, ... }:
{

  # TODO: Check https://wiki.archlinux.org/title/Professional_audio

  environment = {
    systemPackages = with pkgs; [
      alsaUtils # ALSA, the Advanced Linux Sound Architecture utils
      alsaTools # ALSA, the Advanced Linux Sound Architecture tools
      cadence # Collection of tools useful for audio production
      patchage # Modular patch bay for Jack and ALSA systems
      pavucontrol # PulseAudio Volume Control
      qjackctl # A Qt application to control the JACK sound server daemon
      zita-njbridge # command line Jack clients to transmit full quality multichannel audio over a local IP network
    ];
  };

  # See: https://nixos.wiki/wiki/PipeWire#Enabling_PipeWire
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    # Bump rt.prio to 88
    config.jack = {
      "context.modules" = [
        # Uses RTKit to boost the data thread priority.
        {
          name = "libpipewire-module-rtkit";
          args = {
            "nice.level" = -11;
            "rt.prio" = 88;
            "rt.time.soft" = 200000;
            "rt.time.hard" = 200000;
          };
          flags = [ "ifexists" "nofail" ];
        }
        # The native communication protocol.
        { name = "libpipewire-module-protocol-native"; }
        # Allows creating nodes that run in the context of the
        # client. Is used by all clients that want to provide
        # data to PipeWire.
        { name = "libpipewire-module-client-node"; }
        # Allows applications to create metadata objects. It creates
        # a factory for Metadata objects.
        { name = "libpipewire-module-metadata"; }
      ];
    };
  };

  # See: https://github.com/NixOS/nixpkgs/issues/63703
  # See: https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/685
  systemd.services."rtkit-daemon".serviceConfig.ExecStart = [
    ""
    "${pkgs.rtkit}/libexec/rtkit-daemon --our-realtime-priority=90 --max-realtime-priority=89"
  ];

  users.groups = {
    audio = { };
  };

  security.pam.loginLimits = [
    # See: https://jackaudio.org/faq/linux_rt_config.html
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
