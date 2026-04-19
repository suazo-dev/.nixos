{ pkgs, spec, lib, ... }:
{
  environment.systemPackages =
    [ pkgs.zsh pkgs.ghostty.terminfo ]
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
            serverAliveInterval = 30;
            serverAliveCountMax = 6;
          };
          mama = {
            host = "mama";
            hostname = "10.0.0.2";
            user = spec.user;
            serverAliveInterval = 30;
            serverAliveCountMax = 6;
          };
        } else { };
    };

    xdg.configFile =
      if spec.hostName == "mama" then {
        "autostart/org_kde_powerdevil.desktop".text = ''
          [Desktop Entry]
          Type=Application
          Name=PowerDevil
          Hidden=true
        '';
      } else { };
  };
}
