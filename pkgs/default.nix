final: prev: {
  ttyper = prev.callPackage ./games/ttyper { };
  rocketchat-desktop = prev.callPackage ./applications/networking/instant-messengers/rocketchat-desktop { };
}
