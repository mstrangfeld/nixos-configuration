{ pkgs, ... }:
{
  environment = {
    systemPackages = with pkgs; [
      julia # High-level performance-oriented dynamical language for technical computing
    ];
  };
}
