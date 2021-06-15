{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    extensions = with pkgs; [
      vscode-extensions.bbenoist.Nix
      vscode-extensions.vscodevim.vim
      vscode-extensions.haskell.haskell
      vscode-extensions.golang.Go
      vscode-extensions.editorconfig.editorconfig
      vscode-extensions.redhat.vscode-yaml
      vscode-extensions.ms-python.python
      vscode-extensions.ms-python.vscode-pylance
      vscode-extensions.pkief.material-icon-theme
      vscode-extensions.james-yu.latex-workshop
      vscode-extensions.ms-kubernetes-tools.vscode-kubernetes-tools
    ];
    haskell = {
      enable = false;
    };
  };
}
