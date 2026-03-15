{ pkgs, lib, spec, ... }:
let
  listenPort = spec.facts.network.wireguard.listenPort or null;
in
{
  environment.systemPackages = [ pkgs.wireguard-tools ];
  networking.firewall.allowedUDPPorts = lib.mkIf (listenPort != null) [ listenPort ];
}
