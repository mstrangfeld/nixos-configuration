{ pkgs, ... }:
{
  home.packages = with pkgs; [
    ardour # Multi-track hard disk recording software
    faust # A functional programming language for realtime audio signal processing
    haskellPackages.tidal # Pattern language for improvised music
    helm # A free, cross-platform, polyphonic synthesizer
    orca-c # An esoteric programming language designed to quickly create procedural sequencers
    puredata # A real-time graphical programming environment for audio, video, and graphical processing
    supercollider # Programming language for real time audio synthesis
  ];
  # TODO: SOUL, Overtone, Ossia Score, VCV Rack, Reaper, Vital, yabridge
}
