{ lib, pkgs, spec, ... }:
{
  environment.systemPackages = lib.mkIf (!spec.facts.headless) [
    pkgs.wofi
  ];

  home-manager.users.${spec.user} = lib.mkIf (!spec.facts.headless) ({ config, ... }: {
    xdg.configFile."wofi".source = 
      config.lib.file.mkOutOfStoreSymlink
        "/home/${spec.user}/.nixos/components/launcher/dotfiles/wofi";
  });
}
