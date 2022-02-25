{ config, lib, pkgs, ... }:

with lib;
let cfg = config.modules.development.haskell;
in {
  options.modules.development.haskell.enable = mkEnableOption "Haskell";

  config = mkIf cfg.enable (mkMerge [
    {
      environment.systemPackages = with pkgs; [
        ghc # The Glasgow Haskell Compiler
        haskell-language-server # LSP server for GHC
        stack # The Haskell Tool Stack
      ];
    }

    (mkIf config.modules.desktop.enable {
      home-manager.users.marvin = { pkgs, ... }: {
        programs.vscode.extensions = with pkgs.vscode-extensions; [
          haskell.haskell
          justusadam.language-haskell
        ];
        programs.vscode.haskell.enable = false;
      };
    })
  ]);
}
