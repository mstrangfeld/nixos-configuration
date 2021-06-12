{ pkgs, ... }:
{
  environment = {
    systemPackages = with pkgs; [
      alsaUtils # ALSA, the Advanced Linux Sound Architecture utils
      alsaTools # ALSA, the Advanced Linux Sound Architecture tools
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
    # See: https://nixos.wiki/wiki/PipeWire#Low-latency_setup
    config.pipewire = {
      "context.properties" = {
        "link.max-buffers" = 16;
        "log.level" = 2;
        "default.clock.rate" = 48000;
        "default.clock.quantum" = 32;
        "default.clock.min-quantum" = 32;
        "default.clock.max-quantum" = 32;
        "core.daemon" = true;
        "core.name" = "pipewire-0";
      };
      "context.modules" = [
        {
          name = "libpipewire-module-rtkit";
          args = {
            "nice.level" = -15;
            "rt.prio" = 88;
            "rt.time.soft" = 200000;
            "rt.time.hard" = 200000;
          };
          flags = [ "ifexists" "nofail" ];
        }
        { name = "libpipewire-module-protocol-native"; }
        { name = "libpipewire-module-profiler"; }
        { name = "libpipewire-module-metadata"; }
        { name = "libpipewire-module-spa-device-factory"; }
        { name = "libpipewire-module-spa-node-factory"; }
        { name = "libpipewire-module-client-node"; }
        { name = "libpipewire-module-client-device"; }
        {
          name = "libpipewire-module-portal";
          flags = [ "ifexists" "nofail" ];
        }
        {
          name = "libpipewire-module-access";
          args = { };
        }
        { name = "libpipewire-module-adapter"; }
        { name = "libpipewire-module-link-factory"; }
        { name = "libpipewire-module-session-manager"; }
      ];
    };
  };

  security.rtkit.enable = true;

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
    # See: https://wiki.archlinux.org/title/PipeWire#Increasing_RLIMIT_MEMLOCK
    {
      domain = "@audio";
      item = "memlock";
      type = "soft";
      value = "64";
    }
    {
      domain = "@audio";
      item = "memlock";
      type = "hard";
      value = "128";
    }
  ];
}
