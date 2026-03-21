{ pkgs, lib, spec, ... }:
{
  home-manager.users.${spec.user} = lib.mkIf (!spec.facts.headless) ({ ... }: {
    gtk = {
      enable = true;

      theme = {
        name = "Adwaita-dark";
        package = pkgs.gnome-themes-extra;
      };

      iconTheme = {
        name = "Papirus";
        package = pkgs.papirus-icon-theme;
      };

      cursorTheme = {
        name = spec.facts.theme.cursor.name;
        package = pkgs.bibata-cursors;
        size = spec.facts.theme.cursor.size;
      };
    };

    home.pointerCursor = {
      gtk.enable = true;
      x11.enable = true;
      package = pkgs.bibata-cursors;
      name = spec.facts.theme.cursor.name;
      size = spec.facts.theme.cursor.size;
    };

    home.sessionVariables = {
      GTK_THEME = "Adwaita-dark";
      XCURSOR_THEME = spec.facts.theme.cursor.name;
      XCURSOR_SIZE = builtins.toString spec.facts.theme.cursor.size;
    };
  });
}
