{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      formulahendry.auto-close-tag
      formulahendry.auto-rename-tag
      ms-vscode.cpptools
      ms-azuretools.vscode-docker
      editorconfig.editorconfig
      golang.Go
      haskell.haskell
      justusadam.language-haskell
      ms-toolsai.jupyter
      ms-kubernetes-tools.vscode-kubernetes-tools
      james-yu.latex-workshop
      pkief.material-icon-theme
      bbenoist.Nix
      ms-python.vscode-pylance
      ms-python.python
      # jprestidge.theme-material-theme # Not yet implemented
      vscodevim.vim
      dotjoshjohnson.xml
      redhat.vscode-yaml
    ];
    haskell = {
      enable = false;
    };
  };
}
