{
  inputs,
  pkgs,
  lib,
  spec,
  ...
}: {
  home-manager.users.${spec.user} = {...}: {
    imports = [inputs.nvf.homeManagerModules.nvf];

    programs.nvf = {
      enable = true;

      settings.vim = {
        viAlias = true;
        vimAlias = true;
        syntaxHighlighting = true;

        options = {
          number = true;
          relativenumber = true;
          expandtab = true;
          shiftwidth = 2;
          tabstop = 2;
          softtabstop = 2;
          wrap = false;
          termguicolors = true;
          clipboard = "unnamedplus";
          mousemoveevent = true;
        };

        theme.enable = false;

        globals = {
          mapleader = " ";
          maplocalleader = "\\";
        };

        extraPlugins = {
          catppuccin = {
            package = pkgs.vimPlugins.catppuccin-nvim;
          };
          smear-cursor = {
            package = pkgs.vimPlugins.smear-cursor-nvim;
          };
          mini-pairs = {
            package = pkgs.vimPlugins.mini-pairs;
          };
          mini-ai = {
            package = pkgs.vimPlugins.mini-ai;
          };
          harpoon2 = {
            package = pkgs.vimPlugins.harpoon2;
          };
          statuscol = {
            package = pkgs.vimPlugins.statuscol-nvim;
          };
          diffview = {
            package = pkgs.vimPlugins.diffview-nvim;
          };
          lualine = {
            package = pkgs.vimPlugins.lualine-nvim;
          };
        };

        telescope.enable = true;
        filetree.neo-tree.enable = true;
        binds.whichKey.enable = true;

        statusline.lualine.enable = false;

        tabline.nvimBufferline = {
          enable = true;
          setupOpts = {
            options = {
              diagnostics = "nvim_lsp";
              always_show_bufferline = false;
              show_buffer_close_icons = false;
              show_close_icon = false;
              separator_style = "thin";
              offsets = [
                {
                  filetype = "neo-tree";
                  text = "Explorer";
                  highlight = "Directory";
                  text_align = "left";
                }
              ];
            };
          };
        };

        git = {
          enable = true;
          gitsigns = {
            enable = true;
            codeActions.enable = true;
            setupOpts = {
              current_line_blame = true;
              current_line_blame_opts = {
                virt_text = true;
                virt_text_pos = "eol";
                delay = 300;
              };
              signs = {
                add = {text = "┃";};
                change = {text = "┃";};
                delete = {text = "_";};
                topdelete = {text = "‾";};
                changedelete = {text = "~";};
                untracked = {text = "┆";};
              };
            };
          };
        };

        lsp = {
          enable = true;
          formatOnSave = true;
          lightbulb.enable = true;
          lspkind.enable = true;
        };

        autocomplete.blink-cmp = {
          enable = true;
          setupOpts = {
            keymap = {
              "<C-Space>" = ["show"];
              "<C-n>" = ["select_next"];
              "<C-p>" = ["select_prev"];
            };

            signature = {
              enabled = true;
            };

            completion = {
              documentation = {
                auto_show = true;
                auto_show_delay_ms = 200;
                window = {
                  border = "rounded";
                };
              };
              menu = {
                draw = {
                  padding = 0;
                };
              };
            };
          };
        };

        utility = {
          snacks-nvim = {
            enable = true;
            setupOpts = {
              bigfile.enabled = true;
              notifier.enabled = true;
              quickfile.enabled = true;
              indent.enabled = true;
              scroll.enabled = true;
              dashboard = {
                enabled = true;
                sections = [
                  {section = "header";}
                  {
                    section = "keys";
                    gap = 1;
                    padding = 1;
                  }
                  {section = "startup";}
                ];
              };
            };
          };

          smart-splits.enable = true;
        };

        visuals = {
          nvim-web-devicons.enable = true;
          highlight-undo.enable = true;
          fidget-nvim.enable = true;
          indentBlankline.enable = true;
        };

        debugger.nvim-dap = {
          enable = true;
          ui.enable = true;
        };

        ui.borders = {
          enable = true;
          globalStyle = "rounded";
        };

        languages = {
          enableTreesitter = true;
          enableFormat = true;

          nix = {
            enable = true;
            lsp = {
              enable = true;
              servers = ["nixd"];
            };
            treesitter.enable = true;
            format = {
              enable = true;
              type = ["alejandra"];
            };
          };

          rust = {
            enable = true;
            lsp.enable = true;
            treesitter.enable = true;
            format = {
              enable = true;
              type = ["rustfmt"];
            };
          };

          python = {
            enable = true;
            lsp = {
              enable = true;
              servers = ["ruff" "ty"];
            };
            treesitter.enable = true;
            format = {
              enable = true;
              type = ["ruff"];
            };
          };

          clang = {
            enable = true;
            lsp = {
              enable = true;
              servers = ["clangd"];
            };
            treesitter.enable = true;
          };
        };

        luaConfigRC.theme = ''
          require("catppuccin").setup({
            flavour = "mocha",
            color_overrides = {
              mocha = {
                base = "#000000",
                mantle = "#000000",
                crust = "#000000",
              },
            },
            integrations = {
              blink_cmp = true,
              lualine = true,
              gitsigns = true,
              treesitter = true,
              telescope = { enabled = true },
              neotree = true,
              native_lsp = {
                enabled = true,
                underlines = {
                  errors = { "undercurl" },
                  hints = { "undercurl" },
                  warnings = { "undercurl" },
                  information = { "undercurl" },
                },
              },
              which_key = true,
              indent_blankline = { enabled = true },
              dap = { enabled = true, enable_ui = true },
              fidget = true,
              mini = { enabled = true },
              snacks = true,
            },
          })

          vim.cmd.colorscheme("catppuccin")
        '';

        luaConfigRC.lualine-custom = ''
          require("lualine").setup({
            options = {
              theme = "auto",
              component_separators = { left = "|", right = "|" },
              section_separators = { left = "", right = "" },
              globalstatus = true,
              disabled_filetypes = {
                statusline = { "dashboard", "snacks_dashboard" },
              },
            },
            sections = {
              lualine_a = { "mode" },
              lualine_b = { "branch", "diff" },
              lualine_c = {
                { "diagnostics", symbols = { error = " ", warn = " ", info = " ", hint = " " } },
                { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
                { "filename", path = 1 },
              },
              lualine_x = { "encoding", "fileformat" },
              lualine_y = { "progress" },
              lualine_z = { "location" },
            },
          })
        '';

        luaConfigRC.extra-plugins = ''
          require("smear_cursor").setup({
            stiffness = 0.8,
            trailing_stiffness = 0.5,
            distance_stop_animating = 0.5,
          })

          require("mini.pairs").setup()
          require("mini.ai").setup()

          local harpoon = require("harpoon")
          harpoon:setup()
          vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end, { desc = "Harpoon add" })
          vim.keymap.set("n", "<leader>h", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon menu" })
          vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end, { desc = "Harpoon 1" })
          vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end, { desc = "Harpoon 2" })
          vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end, { desc = "Harpoon 3" })
          vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end, { desc = "Harpoon 4" })

          local builtin = require("statuscol.builtin")
          require("statuscol").setup({
            relculright = true,
            segments = {
              { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
              { text = { "%s" }, click = "v:lua.ScSa" },
              { text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
            },
          })

          require("diffview").setup({
            enhanced_diff_hl = true,
          })

          vim.opt.winborder = "rounded"

          vim.keymap.set("n", "<leader>e", "<cmd>Neotree filesystem reveal left<cr>", { desc = "Explorer" })
          vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "LSP hover" })
          vim.keymap.set("n", "<leader>gd", "<cmd>DiffviewOpen<cr>", { desc = "Diffview open" })
          vim.keymap.set("n", "<leader>gD", "<cmd>DiffviewClose<cr>", { desc = "Diffview close" })

          vim.keymap.set("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
          vim.keymap.set("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
          vim.keymap.set("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Close buffer" })
        '';
      };
    };
  };
}
