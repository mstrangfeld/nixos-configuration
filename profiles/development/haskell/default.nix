{ pkgs, ... }:
{
  environment = {
    systemPackages = with pkgs; [
      ghc # The Glasgow Haskell Compiler
      haskell-language-server # LSP server for GHC
    ];
  };
}
