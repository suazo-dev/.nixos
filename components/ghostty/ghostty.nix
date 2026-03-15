{ lib, pkgs, spec, ... }:
{
  environment.systemPackages = lib.mkIf (!spec.facts.headless) [ pkgs.ghostty ];

  home-manager.users.${spec.user} = lib.mkIf (!spec.facts.headless) ({ config, ... }: {
    xdg.configFile."ghostty".source = 
      config.lib.file.mkOutOfStoreSymlink
      "/home/${spec.user}/.nixos/components/ghostty/dotfiles/ghostty";
  });
}
