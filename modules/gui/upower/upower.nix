{ lib, spec, ... }:
{
  services.upower.enable =
    if spec.hostName == "mama"
    then lib.mkForce false
    else lib.mkIf (!spec.facts.headless) true;
}
