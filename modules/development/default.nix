{ options, config, lib, pkgs, ... }:

with lib;
let cfg = config.modules.development;
in {
  options.modules.development.enable = mkEnableOption "Development";

  imports = [
    ./arduino
    ./go
    ./haskell
    ./java
    ./javascript
    ./julia
    ./kubernetes
    ./markup
    ./python
    ./rust
    ./sql
    ./virtualisation
  ];

  config = mkIf cfg.enable {
    environment = {
      systemPackages = with pkgs; [
        bash # GNU Bourne-Again Shell, the de facto standard shell on Linux
        clang # A C language family frontend for LLVM (wrapper script)
        clang-tools # Standalone command line tools for C++ development
        exercism # A Go based command line tool for exercism.io
        gdb # The GNU Project debugger
        gnumake # A tool to control the generation of non-source files from sources
        gcc # GNU Compiler Collection, version 10.3.0 (wrapper script)
        nixfmt # An opinionated formatter for Nix
        nixpkgs-fmt # Nix code formatter for nixpkgs
        perl # The standard implementation of the Perl 5 programmming language
        rr # Records nondeterministic executions and debugs them deterministically
      ];
    };
  };
}
