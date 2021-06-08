{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    extensions = with pkgs; [
      vscode-extensions.bbenoist.Nix
    ];
    haskell = {
      enable = false;
    };
  };
}
