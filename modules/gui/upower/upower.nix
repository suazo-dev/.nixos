{ lib, spec, ... }:
{
  services.upower.enable = lib.mkIf (!spec.facts.headless) true;
}
