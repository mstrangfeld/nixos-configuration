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
        alsa-utils # ALSA, the Advanced Linux Sound Architecture utils
        alsa-tools # ALSA, the Advanced Linux Sound Architecture tools
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
