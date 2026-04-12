{ pkgs, spec, ... }:
{
  environment.systemPackages = [ pkgs.zsh ];

  environment.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  home-manager.users.${spec.user} = { ... }: {
    home.file.".zshrc".source = ./dotfiles/.zshrc;
  };
}
