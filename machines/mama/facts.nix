{
  formFactor = "main-machine";
  gui = true;
  headless = false;

  sshAuthorizedKeys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIkwZUBkhznVjOcbgGAfQUKYOQJtNjxnTT3LDM2KMgcMB"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIM7RdfzUhnGivqsg+jlhyFb0V1yZY8YqZFmwpatZoDap"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDZmKT4DsStSgGCTBBHFk4B4YJ+NW2zXAZisaKF3MEpo"
  ];

  theme = {
    dark = true;
    cursor = {
      package = "bibata-cursors";
      name = "Bibata-Modern-Classic";
      size = 24;
    };
  };

  dotfiles.mode = "store-backed";

  network = {
    ethernet = true;
    wifi = false;
    lanInterface = "eno1";
    wakeMac = "c4:65:16:b6:8c:3c";
    tinyIp = "192.168.8.108";

    wireguard = {
      enable = true;
      endpoint = "192.168.8.108:51820";
      address = "10.0.0.2/24";
      listenPort = 51822;
    };

    tinyWg0PublicKey = "wkQE+ob7KUFxcX44JEY1Lt/Ih3ujp1qZeQ3B1h5vKFA=";
  };

  sync.folder = "/home/suazo/Sync";
}
