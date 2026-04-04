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
    tinyIp = "192.168.8.40";

    wireguard = {
      enable = false;
      endpoint = "teenytiny.duckdns.org:51820";
      address = "10.0.0.2/24";
    };

    tinyWireguardPublicKey = "CHANGE_ME";
  };

  sync.folder = "/home/suazo/Sync";
}
