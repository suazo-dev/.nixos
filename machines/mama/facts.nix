{
  formFactor = "main-machine";
  gui = true;
  headless = false;

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
