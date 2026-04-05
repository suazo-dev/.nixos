{
  formFactor = "gateway";
  gui = false;
  headless = true;

  dotfiles.mode = "store-backed";

  network = {
    ethernet = true;
    wifi = false;
    useNetworkManager = false;
    useIwd = false;
    mamaIp = "192.168.8.10";
    teeIp = "192.168.8.20";
    slimIp = "192.168.8.30";
    duckdnsDomain = "teenytiny.duckdns.org";

    wireguard = {
      wg0 = {
        address = "10.0.0.1/24";
        listenPort = 51820;
      };
      wg1 = {
        address = "10.1.0.1/24";
        listenPort = 51821;
      };
    };

    mamaWireguardPublicKey = "CHANGE_ME";
    teeWireguardPublicKey = "ZYVWprVyyBZ3twqlG0Oy4M4yFOd1k+rg2JvDZZgS6Bc=";
    slimWireguardPublicKey = "AgTfDPo4SKI9ZHl8EgLMZxIS2cpSlL0vD2d8a7hCKx8=";
  };
}
