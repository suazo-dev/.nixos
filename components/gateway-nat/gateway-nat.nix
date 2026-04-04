{ spec, ... }:
let
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
}
