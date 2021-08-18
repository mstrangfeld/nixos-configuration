{ self, config, lib, pkgs, ... }:
let
  inherit (lib) fileContents;
in
{
  imports = [ ../cachix ];

  nix.systemFeatures = [ "nixos-test" "benchmark" "big-parallel" "kvm" ];

  nixpkgs.config.allowUnfree = true;

  i18n.defaultLocale = "de_DE.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "de-latin1";
  };

  environment = {

    # Bare minimum of tools that should be available on every host
    systemPackages = with pkgs; [
      binutils # Tools for manipulating binaries (linker, assembler, etc.)
      coreutils # The basic file, shell and text manipulation utilities of the GNU operating system
      curl # A command line tool for transferring files with URL syntax
      direnv # A shell extension that manages your environment
      dnsutils # Domain name server
      dosfstools # Utilities for creating and checking FAT and VFAT file systems
      fd # A simple, fast and user-friendly alternative to find
      file # A program that shows the type of files
      git # Distributed version control system
      glances # System monitoring
      gptfdisk # Set of text-mode partitioning tools for Globally Unique Identifier (GUID) Partition Table (GPT) disks
      iputils # A set of small useful utilities for Linux networking
      manix # A Fast Documentation Searcher for Nix
      moreutils # Growing collection of the unix tools that nobody thought to write long ago when unix was young
      nix-index # A files database for nixpkgs
      nmap # A free and open source utility for network discovery and security auditing
      p7zip # A new p7zip fork with additional codecs and improvements (forked from https://sourceforge.net/projects/p7zip/)
      ripgrep # A utility that combines the usability of The Silver Searcher with the raw speed of grep
      unzip # An extraction utility for archives compressed in .zip format
      usbutils # Tools for working with USB devices, such as lsusb
      utillinux # A set of system utilities for Linux
      whois # Intelligent WHOIS client from Debian
    ];

    pathsToLink = [ "/share/zsh" ]; # To enable zsh autocomplete
  };

  # Configure zsh as an interactive shell
  programs.zsh.enable = true;

  fonts = {
    fonts = with pkgs; [
      fira # Mozilla's new typeface, used in Firefox OS
      fira-code # Monospace font with programming ligatures
      fira-code-symbols # FiraCode unicode ligature glyphs in private use area
      fira-mono # Monospace font for Firefox OS
      # hack-font # A typeface designed for source code
      powerline-fonts
      powerline-symbols
      # roboto # The Roboto family of fonts
      # roboto-mono # Google Roboto Mono fonts
      # source-code-pro # A set of monospaced OpenType fonts designed for coding environments
      (nerdfonts.override {
        fonts = [
          "FiraCode"
          # "FiraMono"
          # "Hack"
          # "RobotoMono"
          # "SourceCodePro"
        ];
      }) # Iconic font aggregator, collection, & patcher. 3,600+ icons, 50+ patched fonts
    ];
    fontconfig.defaultFonts = {
      monospace = [ "FiraCode Nerd Font" ];
      sansSerif = [ "Fira Sans" ];
    };
  };

  nix = {
    autoOptimiseStore = true;
    gc.automatic = true;
    optimise.automatic = true;
    useSandbox = true;
    allowedUsers = [ "@wheel" ];
    trustedUsers = [ "root" "@wheel" ];
    extraOptions = ''
      min-free = 536870912
      keep-outputs = true
      keep-derivations = true
      fallback = true
    '';
  };

  services.earlyoom.enable = true;
}
