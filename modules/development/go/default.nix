{ options, config, lib, pkgs, ...}:

with lib;
let cfg = config.modules.development.go;
in {
  options.modules.development.go.enable = mkEnableOption "Go";

  config = mkIf cfg.enable (mkMerge [
    {
      environment.systemPackages = with pkgs; [
        delve # debugger for the Go programming language
        go # The Go Programming language
        go-tools # A collection of tools and libraries for working with Go code, including linters and static analysis
        go2nix # Go apps packaging for Nix
        gopls # Official language server for the Go language
      ];
    }

    (mkIf config.modules.desktop.enable {
      home-manager.users.marvin = { pkgs, ... }: {
        programs.vscode.extensions = with pkgs.vscode-extensions; [
          golang.go
        ];
      };
    })
  ]);
}
