{ pkgs, lib, spec, ... }:
{
  home-manager.users.${spec.user} = lib.mkIf (!spec.facts.headless) ({ ... }: {
    gtk = {
      enable = true;
      theme = {
        name = "Adwaita-dark";
        package = pkgs.gnome-themes-extra;
      };
      cursorTheme = {
        name = spec.facts.theme.cursor.name;
        package = pkgs.bibata-cursors;
        size = spec.facts.theme.cursor.size;
      };
    };

    home.sessionVariables = {
      GTK_THEME = "Adwaita-dark";
      XCURSOR_THEME = spec.facts.theme.cursor.name;
      XCURSOR_SIZE = builtins.toString spec.facts.theme.cursor.size;
    };
  });
}
