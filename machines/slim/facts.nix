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
    ethernet = false;
    wifi = true;
    useNetworkManager = true;
    useIwd = false;
    lanIp = "192.168.8.30";
    tinyIp = "192.168.8.40";
    duckdnsDomain = "teenytiny.duckdns.org";
    headscaleUrl = "https://teenytiny.duckdns.org:8443";
    wireguard = {
      endpoint = "teenytiny.duckdns.org:51820";
      address = "10.8.0.3/24";
    };
  };
  sync.folder = "/home/suazo/Sync";
}
