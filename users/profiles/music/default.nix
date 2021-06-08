{ pkgs, ... }:
{
  home.packages = with pkgs; [
    ardour # Multi-track hard disk recording software
    audacity # Sound editor with graphical UI
    carla # An audio plugin host
    faust # A functional programming language for realtime audio signal processing
    geonkick # A free software percussion synthesizer
    guitarix # A virtual guitar amplifier for Linux running with JACK
    haskellPackages.tidal # Pattern language for improvised music
    helm # A free, cross-platform, polyphonic synthesizer
    lsp-plugins # Collection of open-source audio plugins
    mixxx # Digital DJ mixing software
    mixxx-udev # Custom overlay for usb udev rules
    musescore # Music notation and composition software
    orca-c # An esoteric programming language designed to quickly create procedural sequencers
    puredata # A real-time graphical programming environment for audio, video, and graphical processing
    reaper # Digital audio workstation
    sonic-pi # Free live coding synth for everyone originally designed to support computing and music lessons within schools
    sooperlooper # A live looping sampler capable of immediate loop recording, overdubbing, multiplying, reversing and more
    supercollider # Programming language for real time audio synthesis
    vcv-rack # Open-source virtual modular synthesizer
    zyn-fusion # High quality software synthesizer (Zyn-Fusion GUI)
  ];
  # TODO: SOUL, Overtone, Ossia Score, Vital, yabridge

  home.file = {
    lv2 = {
      source = "${home.homeDirectory}/.nix-profile/lib/lv2";
      target = "${home.homeDirectory}/.lv2";
    };
    vst = {
      source = "${home.homeDirectory}/.nix-profile/lib/vst";
      target = "${home.homeDirectory}/.vst";
    };
  };
}
