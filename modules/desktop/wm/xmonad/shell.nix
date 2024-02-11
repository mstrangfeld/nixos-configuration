{ nixpkgs ? import <nixpkgs> { } }:
let
  inherit (nixpkgs) pkgs;
  inherit (pkgs) haskellPackages;

  haskellDeps = ps: with ps; [ xmonad dbus monad-logger xmonad-contrib ];

  ghc = haskellPackages.ghcWithPackages haskellDeps;

  nixPackages = [ ghc pkgs.gdb haskellPackages.cabal-install ];
in
pkgs.mkShell { nativeBuildInputs = nixPackages; }
