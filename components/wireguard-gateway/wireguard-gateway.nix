{ config, spec, ... }:
let
  n = spec.facts.network;
in
{
  sops.secrets."wireguard/tiny-wg0" = {
    owner = "root";
    group = "root";
    mode = "0400";
    path = "/run/secrets/wireguard/tiny-wg0.key";
  };

  sops.secrets."wireguard/tiny-wg1" = {
    owner = "root";
    group = "root";
    mode = "0400";
    path = "/run/secrets/wireguard/tiny-wg1.key";
  };

  networking.firewall.allowedUDPPorts = [
    n.wireguard.wg0.listenPort
    n.wireguard.wg1.listenPort
  ];

  networking.wg-quick.interfaces = {
    wg0 = {
      address = [ n.wireguard.wg0.address ];
      listenPort = n.wireguard.wg0.listenPort;
      privateKeyFile = config.sops.secrets."wireguard/tiny-wg0".path;

      peers = [
        {
          publicKey = n.mamaWireguardPublicKey;
          allowedIPs = [ "10.0.0.2/32" ];
          persistentKeepalive = 25;
        }
      ];
    };

    wg1 = {
      address = [ n.wireguard.wg1.address ];
      listenPort = n.wireguard.wg1.listenPort;
      privateKeyFile = config.sops.secrets."wireguard/tiny-wg1".path;

      peers = [
        {
          publicKey = n.teeWireguardPublicKey;
          allowedIPs = [ "10.1.0.2/32" ];
          persistentKeepalive = 25;
        }
        {
          publicKey = n.slimWireguardPublicKey;
          allowedIPs = [ "10.1.0.3/32" ];
          persistentKeepalive = 25;
        }
      ];
    };
  };
}
