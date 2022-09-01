{ config, pkgs, ... }:
let
  nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
    export __NV_PRIME_RENDER_OFFLOAD=1
    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __VK_LAYER_NV_optimus=NVIDIA_only
    exec "$@"
  '';
in {
  system.stateVersion = "22.05";
  home-manager.users.marvin.home.stateVersion = "22.05";

  imports = [ ./hardware-configuration.nix ];

  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    zfs = { enableUnstable = true; };
    initrd.supportedFilesystems = [ "zfs" ];
    supportedFilesystems = [ "zfs" ];
    loader.grub.copyKernels = true;
  };

  time.timeZone = "Europe/Berlin";

  networking.hostId = "bc995e69";

  # VIDEO AND X-SERVER

  hardware.nvidia.modesetting.enable = true;
  hardware.nvidia.prime = {
    offload.enable = true;

    # Bus ID of the Intel GPU. You can find it using lspci, either under 3D or VGA
    intelBusId = "PCI:0:2:0";

    # Bus ID of the NVIDIA GPU. You can find it using lspci, either under 3D or VGA
    nvidiaBusId = "PCI:1:0:0";
  };

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  services.xserver = {
    enable = true;
    videoDrivers = [ "nvidia" ];

    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;

    layout = "de";
    xkbOptions = "eurosign:e";

    libinput = { enable = true; };
  };

  programs.xwayland.enable = true;

  environment.systemPackages = with pkgs; [ nvidia-offload ];

  services.fprintd = {
    enable = true;
    tod.enable = true;
    tod.driver = pkgs.libfprint-2-tod1-vfs0090;
  };

  modules = {
    desktop = {
      enable = true;
      audio.enable = true;
      browser = {
        default = "brave";
        brave.enable = true;
        firefox.enable = true;
      };
      games.enable = true;
      gnome.enable = true;
      yubikey.enable = true;
    };
    development = {
      enable = true;
      arduino.enable = true;
      go.enable = true;
      haskell.enable = true;
      java.enable = true;
      javascript.enable = true;
      julia.enable = true;
      kubernetes.enable = true;
      markup.enable = true;
      python.enable = true;
      rust.enable = true;
      sql.enable = true;
      virtualisation = {
        enable = true;
        enableNvidia = true;
      };
    };
    network = { enable = true; };
    shell.enable = true;
    theme.enable = true;
  };
}
