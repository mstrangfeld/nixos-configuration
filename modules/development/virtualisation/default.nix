{ config, lib, pkgs, ... }:

with lib;
let cfg = config.modules.development.virtualisation;
in {
  options.modules.development.virtualisation = {
    enable = mkEnableOption "Virtualisation";
    enableNvidia = mkEnableOption "Enable Nvidia Support";
  };

  config = mkIf cfg.enable {
    environment = {
      systemPackages = with pkgs; [
        buildah # A tool which facilitates building OCI images
        dive # A tool for exploring each layer in a docker image
        lazydocker # A simple terminal UI for both docker and docker-compose
        virt-manager # Desktop user interface for managing virtual machines
        qemu
        qemu-utils
        virtio-win
      ];
    };

    programs.dconf.enable = true;

    virtualisation = {
      containers = {
        enable = true;
        storage.settings = {
          storage = {
            driver = "zfs";
            graphroot = "/var/lib/containers/storage";
            runroot = "/run/containers/storage";
          };
        };
      };
      podman = { enable = true; };
      docker = {
        enable = true;
        enableNvidia = cfg.enableNvidia;
      };

      libvirtd = {
        enable = true;
      };
    };
  };
}
