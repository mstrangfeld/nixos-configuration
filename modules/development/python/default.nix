{ config, lib, pkgs, ... }:

with lib;
let cfg = config.modules.development.python;
in {
  options.modules.development.python.enable = mkEnableOption "Python";

  config = mkIf cfg.enable (mkMerge [
    {
      environment.systemPackages = with pkgs; [
        python3 # A high-level dynamically-typed programming language
        python-language-server # Microsoft Language Server for Python
      ];
    }

    (mkIf config.modules.desktop.enable {
      home-manager.users.marvin = { pkgs, ... }: {
        programs.vscode.extensions = with pkgs.vscode-extensions; [
          ms-python.vscode-pylance
          ms-python.python
        ];
      };
    })
  ]);
}
