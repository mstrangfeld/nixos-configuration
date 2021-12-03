{ pkgs, ... }:
{
  environment = {
    systemPackages = with pkgs; [
      python3 # A high-level dynamically-typed programming language
      python-language-server # Microsoft Language Server for Python
    ];
  };
}
