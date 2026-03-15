{ lib, spec, ... }:
let
  configured =
    (spec.facts.network ? headscaleUrl)
    && (spec.facts.network.headscaleUrl != "https://CHANGE_ME.duckdns.org");
in
{
  services.tailscale.enable = lib.mkDefault configured;
  services.tailscale.extraSetFlags =
    lib.mkIf configured [ "--login-server=${spec.facts.network.headscaleUrl}" ];
}
