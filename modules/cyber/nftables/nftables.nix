{ lib, spec, ... }:
let
  n = spec.facts.network;
  hasRole = role: builtins.elem role spec.roles;
  tinyLan = n.tinyIp or null;
  wg1Port = if hasRole "gateway" then toString n.wireguard.wg1.listenPort else null;
in {
  boot.kernel.sysctl = lib.mkIf (hasRole "gateway") {
    "net.ipv4.ip_forward" = 1;
    "net.ipv6.conf.all.forwarding" = 1;
  };

  networking.firewall.enable = hasRole "portal";
  networking.nftables.enable = hasRole "gateway" || hasRole "core";

  networking.nftables.tables = lib.mkMerge [
    (lib.mkIf (hasRole "gateway") {
      gateway = {
        family = "inet";
        content = ''
          chain input {
            type filter hook input priority 0; policy drop;
            iifname "lo" accept
            ct state established,related accept

            iifname "wg1" accept

            ip protocol icmp accept
            udp dport ${wg1Port} accept
            tcp dport 22 accept
          }

          chain forward {
            type filter hook forward priority 0; policy drop;
            ct state established,related accept
          }
        '';
      };
    })
    (lib.mkIf (hasRole "core") {
      core = {
        family = "inet";
        content = ''
          chain input {
            type filter hook input priority 0; policy drop;
            iifname "lo" accept
            ct state established,related accept

            iifname "wg0" accept
            ip saddr ${tinyLan} tcp dport 22 accept
            ip protocol icmp accept
          }

          chain forward {
            type filter hook forward priority 0; policy drop;
          }

          chain output {
            type filter hook output priority 0; policy accept;
          }
        '';
      };
    })
  ];
}
