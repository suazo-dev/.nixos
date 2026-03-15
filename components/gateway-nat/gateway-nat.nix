{ lib, spec, ... }:
let
  iface = spec.facts.network.lanInterface or "CHANGE_ME";
  configured = iface != "CHANGE_ME";
in
{
  networking.nftables.enable = lib.mkIf configured true;

  networking.nftables.tables.gateway-nat = lib.mkIf configured {
    family = "ip";
    content = ''
      chain postrouting {
        type nat hook postrouting priority 100;
        oifname "${iface}" masquerade
      }
    '';
  };
}
