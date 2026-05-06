{ pkgs, spec, lib, ... }:
let
  hasRole = role: builtins.elem role spec.roles;
in
{
  environment.systemPackages =
    [ pkgs.zsh pkgs.ghostty.terminfo ]
    ++ lib.optionals (hasRole "portal") [ pkgs.wakeonlan ];

  environment.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  home-manager.users.${spec.user} = { ... }: {
    home.file.".zshrc".source = ./dotfiles/.zshrc;
    xdg.configFile = {
      "zsh/host-flags.zsh".text = ''
        export ZSH_HOST_HEADLESS=${if spec.facts.headless or false then "1" else "0"}
        export ZSH_HOST_CORE=${if hasRole "core" then "1" else "0"}
        export ZSH_HOST_PORTAL=${if hasRole "portal" then "1" else "0"}
        export ZSH_HOST_GATEWAY=${if hasRole "gateway" then "1" else "0"}
      '';
      "zsh/catppuccin_mocha-zsh-syntax-highlighting.zsh".source = ./dotfiles/catppuccin_mocha-zsh-syntax-highlighting.zsh;
    } // lib.optionalAttrs (hasRole "core") {
      "autostart/org_kde_powerdevil.desktop".text = ''
        [Desktop Entry]
        Type=Application
        Name=PowerDevil
        Hidden=true
      '';
    };
    programs.ssh = {
      enable = true;
      enableDefaultConfig = false;
      matchBlocks =
        {
          "*" = {};
        }
        // (if hasRole "portal" then {
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
        } else { });
    };

  };
}
