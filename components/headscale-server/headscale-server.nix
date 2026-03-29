{
  lib,
  spec,
  ...
}: let
  domain = spec.facts.network.duckdnsDomain;
  configured =
    (spec.facts.network ? headscaleUrl)
    && (spec.facts.network.headscaleUrl != "https://CHANGE_ME.duckdns.org");
in {
  services.headscale = lib.mkIf configured {
    enable = true;
    settings = {
      server_url = spec.facts.network.headscaleUrl;
      listen_addr = "0.0.0.0:8443";
      metrics_listen_addr = "127.0.0.1:9090";
      tls_cert_path = "/var/lib/acme/${domain}/fullchain.pem";
      tls_key_path = "/var/lib/acme/${domain}/key.pem";
      prefixes = {
        v4 = "100.64.0.0/10";
        v6 = "fd7a:115c:a1e0::/48";
      };
      dns = {
        base_domain = spec.facts.headscale.baseDomain;
        override_local_dns = true;
        nameservers.global = ["1.1.1.1" "9.9.9.9"];
      };
    };
  };
  networking.firewall.allowedTCPPorts = lib.mkIf configured [8443];
}
