{
  lib,
  pkgs,
  spec,
  ...
}: {
  environment.systemPackages = lib.mkIf (!spec.facts.headless) [pkgs.opencode];

  # home-manager.users.${spec.user} = lib.mkIf (!spec.facts.headless) ({config, ...}: {
  #   xdg.configFile."zed-editor".source =
  #     config.lib.file.mkOutOfStoreSymlink
  #     "/home/${spec.user}/.nixos/components/opencode/dotfiles";
  # });
}
