{ lib, spec, ... }:
{
  programs.niri.enable = lib.mkIf (!spec.facts.headless) true;

  home-manager.users.${spec.user} = lib.mkIf (!spec.facts.headless) ({ config, ... }: {
    xdg.configFile."niri".source = 
      config.lib.file.mkOutOfStoreSymlink
      "/home/${spec.user}/.nixos/components/niri/dotfiles/niri";
  });
}
