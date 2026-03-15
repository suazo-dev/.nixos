{ lib, pkgs, spec, ... }:
{
  environment.systemPackages =
    lib.mkIf (!spec.facts.headless && spec.facts.theme.cursor.package == "bibata-cursors")
      [ pkgs.bibata-cursors ];
}
