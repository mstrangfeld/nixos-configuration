{ pkgs, ... }:
{
  environment = {
    systemPackages = with pkgs; [
      nodejs # Event-driven I/O framework for the V8 JavaScript engine
      nodePackages.npm # a package manager for JavaScript
      yarn # Fast, reliable, and secure dependency management for javascript
    ];
  };
}
