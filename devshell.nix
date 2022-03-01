{ pkgs, ... }:
pkgs.devshell.mkShell {
  name = "nixos-configuration";
  packages = with pkgs; [
    editorconfig-checker
    nixpkgs-fmt
    ssh-to-age
    deploy-rs.deploy-rs
    agenix
    rage
  ];
  commands = [
    {
      name = "nixos-switch";
      help = "Switch the current system to the new configuration";
      command = ''
        set -e
        echo -e "\n\n##### Switching to the new configuration\n"
        cd $PRJ_ROOT
        nixos-rebuild switch --flake .#$(hostname) "$@"
      '';
    }
    {
      name = "fmt";
      help = "Check Nix formatting";
      command = "nixpkgs-fmt \${@} $PRJ_ROOT";
    }
  ];
}
