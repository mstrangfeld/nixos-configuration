{ config, lib, pkgs, ... }:

with lib;
let cfg = config.modules.development.kuernetes;
in {
  options.modules.development.kubernetes.enable = mkEnableOption "Kubernetes";

  config = mkIf cfg.enable (mkMerge [
    {
      environment.systemPackages = with pkgs; [
        k9s # Kubernetes CLI To Manage Your Clusters In Style
        kind # Kubernetes IN Docker
        kubectl # Kubernetes CLI
        kubectx # Fast way to switch between clusters and namespaces in kubectl!
        kubernetes-helm # A package manager for Kubernetes
        lens # The Kubernetes IDE
        minikube # A tool that makes it easy to run Kubernetes locally
      ];
    }

    (mkIf config.modules.desktop.enable {
      home-manager.users.marvin = { pkgs, ... }: {
        programs.vscode.extensions = with pkgs.vscode-extensions; [
          ms-kubernetes-tools.vscode-kubernetes-tools
          redhat.vscode-yaml
        ];
      };
    })
  ]);
}
