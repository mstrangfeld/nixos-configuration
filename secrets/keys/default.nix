{ config, options, lib, pkgs, ... }:
with lib;
let
  userKeys = map (name: builtins.readFile ./user/${name})
    (builtins.attrNames (builtins.readDir ./user));
in
{
  options.secrets = {
    userKeys = mkOption {
      type = types.listOf types.str;
      default = userKeys;
    };
  };
}
