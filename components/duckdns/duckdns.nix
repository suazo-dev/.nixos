{ pkgs, lib, spec, ... }:
let
  configured =
    (spec.facts.network ? duckdnsDomain)
    && (spec.facts.network.duckdnsDomain != "CHANGE_ME.duckdns.org");

  updateScript = pkgs.writeShellScript "duckdns-update" ''
    set -euo pipefail
    DOMAIN="${spec.facts.network.duckdnsDomain}"
    TOKEN_FILE="/etc/duckdns/token"
    if [ ! -f "$TOKEN_FILE" ]; then
      exit 0
    fi
    TOKEN="$(tr -d '\n' < "$TOKEN_FILE")"
    ${pkgs.curl}/bin/curl -fsS "https://www.duckdns.org/update?domains=''${DOMAIN%%.duckdns.org}&token=$TOKEN&ip=" >/dev/null
  '';
in
{
  environment.etc."duckdns/token".text = lib.mkIf configured "CHANGE_ME";

  systemd.services.duckdns-update = lib.mkIf configured {
    description = "Update DuckDNS";
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${updateScript}";
    };
  };

  systemd.timers.duckdns-update = lib.mkIf configured {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnBootSec = "2m";
      OnUnitActiveSec = "5m";
      Unit = "duckdns-update.service";
    };
  };
}
