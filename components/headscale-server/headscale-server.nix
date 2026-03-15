{ lib, spec, ... }:
let
  configured =
    (spec.facts.network ? headscaleUrl)
    && (spec.facts.network.headscaleUrl != "https://CHANGE_ME.duckdns.org");
in
{
  services.headscale = lib.mkIf configured {
    enable = true;
    settings = {
      server_url = spec.facts.network.headscaleUrl;
      listen_addr = "0.0.0.0:8080";
      metrics_listen_addr = "127.0.0.1:9090";
      prefixes = {
        v4 = "100.64.0.0/10";
        v6 = "fd7a:115c:a1e0::/48";
      };
      dns.base_domain = spec.facts.headscale.baseDomain;
    };
  };

  networking.firewall.allowedTCPPorts = lib.mkIf configured [ 8080 ];
}
