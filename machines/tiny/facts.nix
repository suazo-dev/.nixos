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
    lanIp = "192.168.8.40";
    mamaIp = "192.168.8.10";
    teeIp = "192.168.8.20";
    slimIp = "192.168.8.30";
    lanInterface = "CHANGE_ME";
    duckdnsDomain = "CHANGE_ME.duckdns.org";
    headscaleUrl = "https://CHANGE_ME.duckdns.org";
    wireguard = {
      listenPort = 51820;
      address = "10.8.0.1/24";
    };
  };

  headscale.baseDomain = "tail.suazo";
}
