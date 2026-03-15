{ lib, spec, ... }:
let
  tiny = spec.facts.network.tinyIp or null;
  tee = spec.facts.network.teeIp or null;
  slim = spec.facts.network.slimIp or null;
  configured = tiny != null && tee != null && slim != null;
in
{
  networking.nftables.enable = lib.mkIf configured true;
  networking.firewall.enable = lib.mkIf configured false;

  networking.nftables.tables.vault-filter = lib.mkIf configured {
    family = "inet";
    content = ''
      chain input {
        type filter hook input priority 0; policy drop;
        iifname lo accept
        ct state established,related accept

        ip saddr ${tiny} tcp dport 22 accept
        ip saddr ${tee} tcp dport 22000 accept
        ip saddr ${slim} tcp dport 22000 accept
        ip saddr ${tee} udp dport 22000 accept
        ip saddr ${slim} udp dport 22000 accept
        ip saddr ${tee} udp dport 21027 accept
        ip saddr ${slim} udp dport 21027 accept
      }

      chain forward { type filter hook forward priority 0; policy drop; }
      chain output  { type filter hook output  priority 0; policy accept; }
    '';
  };
}
