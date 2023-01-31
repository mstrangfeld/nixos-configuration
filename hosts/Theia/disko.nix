{ ... }: {
  disk = {
    nvme0n1 = {
      type = "disk";
      device = "/dev/nvme0n1";
      content = {
        type = "table";
        format = "gpt";
        partitions = [
          {
            type = "partition";
            name = "ESP";
            start = "1MiB";
            end = "1GiB";
            fs-type = "fat32";
            bootable = true;
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
            };
          }
          {
            type = "partition";
            name = "zfs";
            start = "1GiB";
            end = "100%";
            content = {
              type = "zfs";
              pool = "tank";
            };
          }
        ];
      };
    };
  };
  zpool = {
    tank = {
      type = "zpool";
      options = {
        ashift = "12";
        autotrim = "on";
        cachefile = "none";
        altroot = "/mnt";
      };
      rootFsOptions = {
        acltype = "posixacl";
        canmount = "off";
        compression = "lz4";
        dnodesize = "auto";
        normalization = "formD";
        relatime = "on";
        xattr = "sa";
        mountpoint = "none";

        encryption = "aes-256-gcm";
        keyformat = "passphrase";
        keylocation = "prompt";
      };

      datasets = {
        "root" = {
          zfs_type = "filesystem";
          mountpoint = "/";
          options = {
            mountpoint = "legacy";
          };
        };
        "nix" = {
          zfs_type = "filesystem";
          mountpoint = "/nix";
          options.mountpoint = "legacy";
        };
        "home" = {
          zfs_type = "filesystem";
          mountpoint = "/home";
          options.mountpoint = "legacy";
        };

        swap = {
          zfs_type = "volume";
          size = "16G";
          options = {
            volblocksize = "4096";
            compression = "zle";
            logbias = "throughput";
            sync = "always";
            primarycache = "metadata";
            secondarycache = "none";
            "com.sun:auto-snapshot" = "false";
          };
          content = {
            type = "swap";
          };
        };
      };
    };
  };
}
