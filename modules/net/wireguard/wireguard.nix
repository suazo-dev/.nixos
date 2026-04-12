{
  config,
  lib,
  spec,
  ...
}: let
  n = spec.facts.network;
  hasRole = role: builtins.elem role spec.roles;
in {
  sops.secrets = lib.mkMerge [
    (lib.mkIf (hasRole "portal") {
      "wireguard/${spec.hostName}" = {
        owner = "root";
        group = "root";
        mode = "0400";
        path = "/run/secrets/wireguard/${spec.hostName}.key";
      };
    })
    (lib.mkIf (hasRole "gateway") {
      "wireguard/tiny-wg1" = {
        owner = "root";
        group = "root";
        mode = "0400";
        path = "/run/secrets/wireguard/tiny-wg1.key";
      };
    })
    (lib.mkIf (hasRole "core") {
      "wireguard/mama" = {
        owner = "root";
        group = "root";
        mode = "0400";
        path = "/run/secrets/wireguard/mama.key";
      };
    })
  ];

  networking.firewall.allowedUDPPorts = lib.mkIf (hasRole "gateway") [
    n.wireguard.wg1.listenPort
  ];

  networking.wg-quick.interfaces = lib.mkMerge [
    (lib.mkIf (hasRole "portal") {
      wg1 = {
        address = [ n.wireguard.address ];
        privateKeyFile = config.sops.secrets."wireguard/${spec.hostName}".path;

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
    })
    (lib.mkIf (hasRole "gateway") {
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
    })
    (lib.mkIf (hasRole "core" && (n.wireguard.enable or false)) {
      wg0 = {
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
    })
  ];
}
