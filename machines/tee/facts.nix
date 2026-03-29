{
  formFactor = "portal";
  gui = true;
  headless = false;

  theme = {
    dark = true;
    cursor = {
      package = "bibata-cursors";
      name = "Bibata-Modern-Classic";
      size = 32;
    };
  };

  dotfiles.mode = "store-backed";

  network = {
    ethernet = true;
    wifi = true;
    useNetworkManager = true;
    useIwd = true;
    lanIp = "192.168.8.20";
    tinyIp = "192.168.8.40";
    duckdnsDomain = "teenytiny.duckdns.org";
    headscaleUrl = "https://teenytiny.duckdns.org";
    wireguard = {
      endpoint = "teenytiny.duckdns.org:51820";
      address = "10.8.0.2/24";
    };
  };

  sync.folder = "/home/suazo/Sync";
}
