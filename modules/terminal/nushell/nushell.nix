{ pkgs, spec, ... }:
{
  environment.systemPackages = [ pkgs.nushell ];

  home-manager.users.${spec.user} = { config, ... }: {
    xdg.configFile."nushell".source =
      config.lib.file.mkOutOfStoreSymlink
      "/home/${spec.user}/.nixos/modules/terminal/nushell/dotfiles/nushell";
  };
}
