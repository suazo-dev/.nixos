{ config, lib, spec, ... }:
let
  n = spec.facts.network;
  wgEnabled = n.wireguard.enable or false;
in
{
  sops.secrets."wireguard/mama" = {
    owner = "root";
    group = "root";
    mode = "0400";
    path = "/run/secrets/wireguard/mama.key";
  };

  networking.wg-quick.interfaces.wg0 = lib.mkIf wgEnabled {
    address = [ n.wireguard.address ];
    privateKeyFile = config.sops.secrets."wireguard/mama".path;

    peers = [
      {
        publicKey = n.tinyWireguardPublicKey;
        endpoint = n.wireguard.endpoint;
        allowedIPs = [ "0.0.0.0/0" ];
        persistentKeepalive = 25;
      }
    ];
  };
}
