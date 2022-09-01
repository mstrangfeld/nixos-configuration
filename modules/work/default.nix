{ config, lib, pkgs, ... }:

with lib;
let cfg = config.modules.work;
in {
  options.modules.work = {
    open-xchange = mkEnableOption "Open-Xchange";
  };

  config = (mkMerge [
    (mkIf cfg.open-xchange {
      home-manager.users.marvin = { pkgs, ... }: {
        programs.git.includes = [
          {
            condition = "gitdir:~/work/ox/";
            contents = {
              user = {
                name = "Marvin Strangfeld";
                email = "marvin.strangfeld@open-xchange.com";
              };
              commit = {
                gpgSign = false;
              };
            };
          }
        ];
        programs.ssh = {
          enable = true;
          matchBlocks = {
            "*.cloud.oxoe.io" = {
              checkHostIP = false;
              extraOptions = {
                StrictHostKeyChecking = "no";
              };
            };
          };
        };
      };
    })
  ]);
}
