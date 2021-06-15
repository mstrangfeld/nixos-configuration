{ pkgs
, headless ? true
, ...
}:
{
  environment = {
    systemPackages = with pkgs; [
      delve # debugger for the Go programming language
      go # The Go Programming language
      go-tools # A collection of tools and libraries for working with Go code, including linters and static analysis
      go2nix # Go apps packaging for Nix
      gopls # Official language server for the Go language
    ];
  };
}
