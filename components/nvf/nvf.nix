{ inputs, spec, ... }:
{
  home-manager.users.${spec.user} = { ... }: {
    imports = [ inputs.nvf.homeManagerModules.nvf ];

    programs.nvf = {
      enable = true;

      settings.vim = {
        viAlias = true;
        vimAlias = true;
        syntaxHighlighting = true;
        telescope.enable = true;
        filetree.neo-tree.enable = true;
        binds.whichKey.enable = true;
        statusline.lualine.enable = true;

        theme = {
          enable = true;
          name = "gruvbox";
          style = "dark";
        };

        lsp = {
          enable = true;
          formatOnSave = true;
          lightbulb.enable = true;
        };

        autocomplete.blink-cmp.enable = true;

        options = {
          number = true;
          relativenumber = true;
          expandtab = true;
          shiftwidth = 2;
          tabstop = 2;
          softtabstop = 2;
          wrap = false;
          termguicolors = true;
        };
      };
    };
  };
}
