{ self, config, lib, pkgs, ... }:
let inherit (lib) fileContents;
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

    systemPackages = with pkgs; [
      binutils
      coreutils
      curl
      direnv
      dnsutils
      dosfstools
      fd
      git
      gotop
      gptfdisk
      iputils
      jq
      manix
      moreutils
      nix-index
      nmap
      ripgrep
      skim
      tealdeer
      usbutils
      utillinux
      whois
    ];

  };

  fonts = {
    fonts = with pkgs; [ powerline-fonts dejavu_fonts ];

    fontconfig.defaultFonts = {

      monospace = [ "DejaVu Sans Mono for Powerline" ];

      sansSerif = [ "DejaVu Sans" ];

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
