{ config, lib, pkgs, ... }:

with lib;
{
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot = {
    loader.grub = {
      enable = true;
      version = 2;
      device = "/dev/sda";
    };

    supportedFilesystems = [ "zfs" ];
    zfs.requestEncryptionCredentials = true;

    initrd.network = {
      enable = true;
      ssh = {
        enable = true;
        port = 2222;
        hostKeys = [
          "/etc/secrets/initrd/ssh_host_rsa_key"
          "/etc/secrets/initrd/ssh_host_ed25519_key"
        ];
        authorizedKeys = concatLists (mapAttrsToList (name: user: if elem "wheel" user.extraGroups then user.openssh.authorizedKeys.keys else [ ]) config.users.users);
      };
      postCommands = ''
        echo "zfs load-key -a; killall zfs" >> /root/.profile
      '';
    };
  };

  networking = {
    hostName = "Eos";
    hostId = "c1a3072c";
    interfaces.ens3.useDHCP = true;
  };

  # i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "de-latin1";
  };

  services.zfs.autoSnapshot.enable = true;
  services.zfs.autoScrub.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.marvin = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    openssh.authorizedKeys.keys = config.secrets.userKeys;
  };

  users.users.root.openssh.authorizedKeys.keys = config.secrets.userKeys;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.openssh.permitRootLogin = "yes";

  system.stateVersion = "21.11"; # Did you read the comment?

  modules = {
    shell.enable = true;
    server = {
      enable = true;
      nextcloud.enable = true;
      pdns.enable = true;
    };
    network.syncthing = {
      enable = true;
      additionalConfig = {
        guiAddress = "100.114.143.32:8384"; # Tailscale network
        overrideFolders = false;
      };
    };
    network.tailscale.enable = true;
  };

  networking.firewall.interfaces."tailscale0" = {
    allowedTCPPorts = [ 8384 ];
  };
}
