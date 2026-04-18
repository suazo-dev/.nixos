{ spec, ... }:
let
  n = spec.facts.network;
in {
  networking.interfaces.${n.lanInterface} = {
    useDHCP = false;
    ipv4.addresses = [
      {
        address = n.tinyIp;
        prefixLength = 24;
      }
    ];
  };

  networking.defaultGateway = "192.168.8.1";
  networking.nameservers = [
    "192.168.8.1"
    "1.1.1.1"
  ];
}
