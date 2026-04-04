{ spec, ... }:
let
  tinyLan = spec.facts.network.tinyIp;
in
{
  networking.nftables.enable = true;
  networking.firewall.enable = false;

  networking.nftables.tables.vault = {
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
}
