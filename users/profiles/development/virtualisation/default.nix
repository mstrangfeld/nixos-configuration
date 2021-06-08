{ pkgs, ... }:
{
  home.packages = with pkgs; [
    buildah # A tool which facilitates building OCI images
    dive # A tool for exploring each layer in a docker image
    k9s # Kubernetes CLI To Manage Your Clusters In Style
    kind # Kubernetes IN Docker
    kubernetes-helm # A package manager for Kubernetes
    lazydocker # A simple terminal UI for both docker and docker-compose
    lens # The Kubernetes IDE
    minikube # A tool that makes it easy to run Kubernetes locally
  ];
}
