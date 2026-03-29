{ lib, config, spec, ... }:
let
  domain = spec.facts.network.duckdnsDomain;
  configured =
    (spec.facts.network ? duckdnsDomain)
    && (spec.facts.network.duckdnsDomain != "CHANGE_ME.duckdns.org");
in
{
  security.acme = lib.mkIf configured {
    acceptTerms = true;
    defaults.email = "me@suazo.dev";
    certs.${domain} = {
      dnsProvider = "duckdns";
      webroot = null;
      environmentFile = config.sops.secrets.duckdns_acme_env.path;
      group = "headscale";
    };
  };

  sops.secrets.duckdns_acme_env = lib.mkIf configured {
    sopsFile = ../../secrets/duckdns.yaml;
    key = "duckdns_acme_env";
  };
}
```

Save.

**File 2:** `~/.nixos/components/headscale-server/headscale-server.nix`

Open it and remove the `users.groups.acme.members` line if it's still there. Everything else stays.

Then:
```
cd ~/.nixos && git add -A && git commit -m "fix acme component" && git push
```

Then on tiny:
```
cd ~/.nixos && git pull && sudo nixos-rebuild switch --flake .#tiny
