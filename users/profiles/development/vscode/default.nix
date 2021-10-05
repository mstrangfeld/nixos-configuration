{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      # asciidoctor.asciidoctor-vscode # Not yet implemented
      formulahendry.auto-close-tag
      formulahendry.auto-rename-tag
      ms-vscode.cpptools
      ms-azuretools.vscode-docker
      editorconfig.editorconfig
      golang.go
      haskell.haskell
      justusadam.language-haskell
      ms-toolsai.jupyter
      ms-kubernetes-tools.vscode-kubernetes-tools
      james-yu.latex-workshop
      pkief.material-icon-theme
      bbenoist.nix
      ms-python.vscode-pylance
      # ms-python.python # Broken
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
