{ lib, pkgs, spec, ... }:
{
  environment.systemPackages = lib.mkIf (!spec.facts.headless) [ pkgs.ghostty ];

  home-manager.users.${spec.user} = lib.mkIf (!spec.facts.headless) ({ ... }: {
    xdg.configFile."ghostty".source = ./dotfiles/ghostty;
  });
}
