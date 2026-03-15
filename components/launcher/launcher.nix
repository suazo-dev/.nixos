{ lib, pkgs, spec, ... }:
{
  environment.systemPackages = lib.mkIf (!spec.facts.headless) [
    pkgs.wofi
  ];

  home-manager.users.${spec.user} = lib.mkIf (!spec.facts.headless) ({ ... }: {
    xdg.configFile."wofi".source = ./dotfiles/wofi;
  });
}
