{ utils }:
let
  nixosModules = utils.lib.exportModules [
    ./modules/audio
    ./modules/cachix
    ./modules/core
    ./modules/creative
    ./modules/development
    ./modules/desktop
    ./modules/entertainment
    ./modules/graphical
    ./modules/network
    ./modules/users
    ./modules/virtualisation
    ./modules/wm/xmonad
    ./modules/yubikey
    ./modules/v4l2loopback.nix
  ];

  homeManagerModules = utils.lib.exportModules [
    ./home/alacritty
    ./home/browser
    ./home/development
    ./home/music
    ./home/shell
    ./home/users
    ./home/x
  ];

  hmKronos = with homeManagerModules; [
    alacritty
    browser
    development
    # music
    shell
    users
    x
  ];

  baseModules = with nixosModules; [
    cachix
    core
    network
  ];

  desktopModules = with nixosModules; [
    audio
    graphical
    xmonad
  ] ++ baseModules;
in
{
  inherit nixosModules homeManagerModules hmKronos baseModules desktopModules;
}
