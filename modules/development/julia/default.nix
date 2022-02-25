{ config, lib, pkgs, ... }:

with lib;
let cfg = config.modules.development.julia;
in {
  options.modules.development.julia.enable = mkEnableOption "Julia";

  config = mkIf cfg.enable (mkMerge [
    {
      environment.systemPackages = with pkgs; [
        julia-stable-bin # High-level performance-oriented dynamical language for technical computing
      ];
    }

    (mkIf config.modules.desktop.enable {
      home-manager.users.marvin = { pkgs, ... }: {
        programs.vscode.extensions = with pkgs.vscode-extensions; [
          # TODO: Julia extensions
        ];
      };
    })
  ]);
}
