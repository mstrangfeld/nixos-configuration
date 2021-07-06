{ pkgs, ... }:
{
  environment = {
    systemPackages = with pkgs; [
      julia-stable-bin # High-level performance-oriented dynamical language for technical computing
    ];
  };
}
