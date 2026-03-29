{
  lib,
  config,
  spec,
  ...
}: let
  domain = spec.facts.network.duckdnsDomain;
  configured =
    (spec.facts.network ? duckdnsDomain)
    && (spec.facts.network.duckdnsDomain != "CHANGE_ME.duckdns.org");
in {
  security.acme = lib.mkIf configured {
    acceptTerms = true;
    defaults.email = "me@suazo.dev";
    certs.${domain} = {
      dnsProvider = "duckdns";
      environmentFile = config.sops.secrets.duckdns_acme_env.path;
    };
  };

  sops.secrets.duckdns_acme_env = lib.mkIf configured {
    sopsFile = ../../secrets/duckdns.yaml;
    key = "duckdns_acme_env";
  };
}
