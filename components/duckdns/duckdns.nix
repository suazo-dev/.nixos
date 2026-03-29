{
  pkgs,
  lib,
  config,
  spec,
  ...
}: let
  configured =
    (spec.facts.network ? duckdnsDomain)
    && (spec.facts.network.duckdnsDomain != "CHANGE_ME.duckdns.org");
  updateScript = pkgs.writeShellScript "duckdns-update" ''
    set -euo pipefail
    DOMAIN="${spec.facts.network.duckdnsDomain}"
    TOKEN="$(tr -d '\n' < ${config.sops.secrets.duckdns_token.path})"
    ${pkgs.curl}/bin/curl -fsS "https://www.duckdns.org/update?domains=''${DOMAIN%%.duckdns.org}&token=$TOKEN&ip=" >/dev/null
  '';
in {
  sops.secrets.duckdns_token = lib.mkIf configured {
    sopsFile = ../../secrets/duckdns.yaml;
    key = "duckdns_token";
  };
  systemd.services.duckdns-update = lib.mkIf configured {
    description = "Update DuckDNS";
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${updateScript}";
    };
  };
  systemd.timers.duckdns-update = lib.mkIf configured {
    wantedBy = ["timers.target"];
    timerConfig = {
      OnBootSec = "2m";
      OnUnitActiveSec = "5m";
      Unit = "duckdns-update.service";
    };
  };
}
