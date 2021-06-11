{ pkgs, ... }:
{
  environment = {
    systemPackages = with pkgs; [
      ardour # Multi-track hard disk recording software
      audacity # Sound editor with graphical UI
      calf # A set of high quality open source audio plugins for musicians
      caps # A selection of LADSPA plugins implementing classic effects
      carla # An audio plugin host
      dragonfly-reverb # A hall-style reverb based on freeverb3 algorithms
      drumgizmo # An LV2 sample based drum plugin
      ebumeter # Level metering according to the EBU R-128 recommendation
      eq10q # LV2 EQ plugins and more, with 64 bit processing
      faust # A functional programming language for realtime audio signal processing
      geonkick # A free software percussion synthesizer
      guitarix # A virtual guitar amplifier for Linux running with JACK
      haskellPackages.tidal # Pattern language for improvised music
      helm # A free, cross-platform, polyphonic synthesizer
      lsp-plugins # Collection of open-source audio plugins
      mda_lv2 # An LV2 port of the MDA plugins by Paul Kellett
      mixxx # Digital DJ mixing software
      mixxx-udev # Custom overlay for usb udev rules
      musescore # Music notation and composition software
      ninjas2 # sample slicer plugin for LV2, VST, and jack standalone
      noise-repellent # An lv2 plugin for broadband noise reduction
      orca-c # An esoteric programming language designed to quickly create procedural sequencers
      puredata # A real-time graphical programming environment for audio, video, and graphical processing
      # reaper # Digital audio workstation
      samplv1 # An old-school all-digital polyphonic sampler synthesizer with stereo fx
      setbfree # A DSP tonewheel organ emulator
      sonic-pi # Free live coding synth for everyone originally designed to support computing and music lessons within schools
      sonic-visualiser # View and analyse contents of music audio files
      sooperlooper # A live looping sampler capable of immediate loop recording, overdubbing, multiplying, reversing and more
      supercollider # Programming language for real time audio synthesis
      swh_lv2 # LV2 version of Steve Harris' SWH plugins
      tap-plugins # Tom's Audio Processing plugins
      vcv-rack # Open-source virtual modular synthesizer
      wolf-shaper # Waveshaper plugin with spline-based graph editor
      x42-plugins # Collection of LV2 plugins by Robin Gareus
      zam-plugins # A collection of LV2/LADSPA/VST/JACK audio plugins by ZamAudio
      zyn-fusion # High quality software synthesizer (Zyn-Fusion GUI)
    ];
  };
  # TODO: SOUL, Overtone, Ossia Score, Vital, yabridge
}
