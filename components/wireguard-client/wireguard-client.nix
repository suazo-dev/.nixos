{ config, spec, ... }:
let
  n = spec.facts.network;
  secretName = "wireguard/${spec.hostName}";
in
{
  sops.secrets.${secretName} = {
    owner = "root";
    group = "root";
    mode = "0400";
    path = "/run/secrets/wireguard/${spec.hostName}.key";
  };

  networking.wg-quick.interfaces.wg1 = {
    address = [ n.wireguard.address ];
    privateKeyFile = config.sops.secrets.${secretName}.path;

    peers = [
      {
        publicKey = n.tinyWireguardPublicKey;
        endpoint = n.wireguard.endpoint;
        allowedIPs = [
          "10.1.0.0/24"
          "10.0.0.0/24"
        ];
        persistentKeepalive = 25;
      }
    ];
  };
}
