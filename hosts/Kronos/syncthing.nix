{ ... }: {
  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
    user = "marvin";
    dataDir = "/home/marvin";
    configDir = "/home/marvin/.config/syncthing";
    overrideDevices = true;
    overrideFolders = true;
    devices = {
      "OnePlusA5020" = {
        id = "MJX5Z2N-BLIQPSY-ZEL6MYN-DGLFYSD-TT6WV54-PO77GLO-HHCCXAV-35AVVQV";
      };
    };
    folders = {
      "Phone Camera" = {
        id = "oneplus_a5020_camera";
        devices = [ "OnePlusA5020" ];
        versioning = {
          type = "trashcan";
          params.cleanoutDays = "60";
        };
        type = "receiveonly";
        path = "/home/marvin/Pictures/phone";
      };
    };
  };
}
