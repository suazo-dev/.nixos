{
  formFactor = "portal";
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
    wifi = true;
    useNetworkManager = true;
    useIwd = true;
    tinyIp = "192.168.8.40";
    mamaIp = "192.168.8.10";

    wireguard = {
      endpoint = "192.168.8.40:51821";
      address = "10.1.0.2/24";
    };

    tinyWireguardPublicKey = "vlwKRiZiTqUIPn3Y7xcSQN8KNWZeRWODNcX8iqeBmT0=";
  };

  sync.folder = "/home/suazo/Sync";
}
