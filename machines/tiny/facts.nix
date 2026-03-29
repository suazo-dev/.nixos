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
    lanInterface = "eno1";
    duckdnsDomain = "teenytiny.duckdns.org";
    headscaleUrl = "https://teenytiny.duckdns.org:8443";
    wireguard = {
      listenPort = 51820;
      address = "10.8.0.1/24";
    };
  };
  headscale.baseDomain = "tail.suazo";
}
