{ pkgs, spec, ... }:
{
  environment.systemPackages = [ pkgs.zsh ];

  home-manager.users.${spec.user} = { ... }: {
    home.file.".zshrc".source = ./dotfiles/.zshrc;
  };
}
