{ pkgs, ... }:
{
  imports = [ ../../virtualisation ];
  environment = {
    systemPackages = with pkgs; [
      k9s # Kubernetes CLI To Manage Your Clusters In Style
      kind # Kubernetes IN Docker
      kubectl # Kubernetes CLI
      kubectx # Fast way to switch between clusters and namespaces in kubectl!
      kubernetes-helm # A package manager for Kubernetes
      lens # The Kubernetes IDE
      minikube # A tool that makes it easy to run Kubernetes locally
    ];
  };
}
