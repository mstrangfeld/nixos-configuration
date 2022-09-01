{ config, lib, pkgs, ... }:

with lib;
let cfg = config.modules.desktop.audio;
in {
  options.modules.desktop.audio.enable = mkEnableOption "Audio";

  config = mkIf cfg.enable {
    # TODO: Check https://wiki.archlinux.org/title/Professional_audio

    boot = {
      kernelParams = [ "threadirq" ];
      # Increasing the highest requested RTC interrupt frequency (default is 64 Hz)
      postBootCommands = ''
        echo 2048 > /sys/class/rtc/rtc0/max_user_freq
        echo 2048 > /proc/sys/dev/hpet/max-user-freq
      '';
    };

    powerManagement.cpuFreqGovernor = "performance";

    environment = {
      systemPackages = with pkgs; [
        alsaUtils # ALSA, the Advanced Linux Sound Architecture utils
        alsaTools # ALSA, the Advanced Linux Sound Architecture tools
        cadence # Collection of tools useful for audio production
        helvum # A GTK patchbay for pipewire
        patchage # Modular patch bay for Jack and ALSA systems
        pavucontrol # PulseAudio Volume Control
        qpwgraph # Qt graph manager for PipeWire, similar to QjackCtl
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
      config.pipewire = {
        "context.properties" = {
          "link.max-buffers" = 16;
          "log.level" = 2;
          "default.clock.rate" = 48000;
          "default.clock.quantum" = 256;
          "default.clock.min-quantum" = 256;
          "default.clock.max-quantum" = 256;
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

    # See: https://github.com/NixOS/nixpkgs/issues/63703
    # See: https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/685
    systemd.services."rtkit-daemon".serviceConfig.ExecStart = [
      ""
      "${pkgs.rtkit}/libexec/rtkit-daemon --our-realtime-priority=90 --max-realtime-priority=89"
    ];

    users.groups = { audio = { }; };

    security.pam.loginLimits = [
      # See: https://jackaudio.org/faq/linux_rt_config.html
      {
        domain = "@audio";
        item = "memlock";
        type = "-";
        value = "unlimited";
      }
      {
        domain = "@audio";
        item = "rtprio";
        type = "-";
        value = "99";
      }
      {
        domain = "@audio";
        item = "nofile";
        type = "soft";
        value = "99999";
      }
      {
        domain = "@audio";
        item = "nofile";
        type = "hard";
        value = "99999";
      }
    ];
  };
}
