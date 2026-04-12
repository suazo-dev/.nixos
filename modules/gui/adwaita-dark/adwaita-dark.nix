{ pkgs, lib, spec, ... }:
{
  home-manager.users.${spec.user} = lib.mkIf (!spec.facts.headless) ({ ... }: {
    gtk = {
      enable = true;
      theme = {
        name = "Adwaita-dark";
        package = pkgs.gnome-themes-extra;
      };
    };

    home.sessionVariables = {
      GTK_THEME = "Adwaita-dark";
    };
  });
}
