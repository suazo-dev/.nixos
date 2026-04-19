{ pkgs, spec, lib, ... }:
{
  environment.systemPackages =
    [ pkgs.zsh ]
    ++ lib.optionals (builtins.elem spec.hostName [ "slim" "tee" ]) [ pkgs.wakeonlan ];

  environment.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  home-manager.users.${spec.user} = { ... }: {
    home.file.".zshrc".source = ./dotfiles/.zshrc;
    programs.ssh = {
      enable = true;
      matchBlocks =
        if builtins.elem spec.hostName [ "slim" "tee" ] then {
          tiny = {
            host = "tiny";
            hostname = "10.1.0.1";
            user = spec.user;
          };
          mama = {
            host = "mama";
            hostname = "10.0.0.2";
            user = spec.user;
          };
        } else { };
    };
  };
}
