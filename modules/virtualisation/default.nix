{ pkgs, ... }:
{
  environment = {
    systemPackages = with pkgs; [
      buildah # A tool which facilitates building OCI images
      dive # A tool for exploring each layer in a docker image
      lazydocker # A simple terminal UI for both docker and docker-compose
    ];
  };

  virtualisation = {
    podman = {
      enable = true;
    };
    docker = {
      enable = true;
      enableNvidia = true;
    };
  };
}
