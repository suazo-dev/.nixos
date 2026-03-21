{
  lib,
  pkgs,
  spec,
  ...
}: {
  environment.systemPackages = lib.mkIf (!spec.facts.headless) (with pkgs; [
    #wofi
    # walker
    # elephant
    fuzzel
  ]);

  home-manager.users.${spec.user} = lib.mkIf (!spec.facts.headless) ({config, ...}: {
    xdg.configFile."fuzzel".source =
      config.lib.file.mkOutOfStoreSymlink
      "/home/${spec.user}/.nixos/components/launcher/dotfiles/fuzzel";
  });
}
