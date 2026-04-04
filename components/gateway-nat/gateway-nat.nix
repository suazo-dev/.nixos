{ spec, ... }:
let
  wg0Port = toString spec.facts.network.wireguard.wg0.listenPort;
  wg1Port = toString spec.facts.network.wireguard.wg1.listenPort;
in
{
  networking.nftables.enable = true;
  networking.firewall.enable = false;

  networking.nftables.tables.gateway = {
    family = "inet";
    content = ''
      chain input {
        type filter hook input priority 0; policy drop;
        iifname "lo" accept
        ct state established,related accept

        iifname "wg0" accept
        iifname "wg1" accept

        ip protocol icmp accept
        udp dport ${wg0Port} accept
        udp dport ${wg1Port} accept
        tcp dport 22 accept
      }

      chain forward {
        type filter hook forward priority 0; policy drop;
        ct state established,related accept

        iifname "wg1" oifname "wg0" accept
        iifname "wg0" oifname "wg1" accept

        iifname "wg0" oifname != { "wg0", "wg1" } accept
      }
    '';
  };

  networking.nftables.tables.gateway_nat = {
    family = "ip";
    content = ''
      chain postrouting {
        type nat hook postrouting priority 100; policy accept;
        ip saddr 10.0.0.0/24 oifname != { "wg0", "wg1" } masquerade
      }
    '';
  };
}
