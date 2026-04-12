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
          signcolumn = "yes";
          expandtab = true;
          shiftwidth = 2;
          tabstop = 2;
          softtabstop = 2;
          wrap = false;
          termguicolors = true;
          clipboard = "unnamedplus";
          mouse = "a";
          mousemoveevent = true;
          updatetime = 250;
          timeoutlen = 400;
          splitbelow = true;
          splitright = true;
          cursorline = true;
        };

        theme.enable = false;
        telescope.enable = false;
        filetree.neo-tree.enable = false;
        binds.whichKey.enable = true;
        statusline.lualine.enable = false;

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
          alpha-nvim = {
            package = pkgs.vimPlugins.alpha-nvim;
          };
          oil = {
            package = pkgs.vimPlugins.oil-nvim;
          };
          opencode = {
            package = pkgs.vimPlugins.opencode-nvim;
          };
          fzf-lua = {
            package = pkgs.vimPlugins.fzf-lua;
          };
        };

        tabline.nvimBufferline = {
          enable = true;
          setupOpts = {
            options = {
              diagnostics = "nvim_lsp";
              always_show_bufferline = false;
              show_buffer_close_icons = false;
              show_close_icon = false;
              separator_style = "thin";
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
          lspSignature.enable = false;
        };

        autocomplete.blink-cmp = {
          enable = true;
          setupOpts = {
            keymap = {
              "<C-Space>" = ["show" "show_documentation" "hide_documentation"];
              "<C-n>" = ["select_next"];
              "<C-p>" = ["select_prev"];
              "<C-f>" = ["scroll_documentation_down"];
              "<C-b>" = ["scroll_documentation_up"];
              "<Tab>" = ["select_next" "fallback"];
              "<S-Tab>" = ["select_prev" "fallback"];
              "<CR>" = ["accept" "fallback"];
              "<C-e>" = ["hide" "cancel"];
            };

            completion = {
              trigger = {
                show_on_keyword = true;
                show_on_trigger_character = true;
                show_on_insert = false;
              };

              list = {
                selection = {
                  preselect = true;
                  auto_insert = false;
                };
              };

              menu = {
                enabled = true;
                auto_show = true;
                auto_show_delay_ms = 0;
                min_width = 32;
                max_height = 14;
                border = "rounded";
                scrollbar = true;
                direction_priority = ["s" "n"];
                draw = {
                  padding = 1;
                  gap = 1;
                  columns = [
                    ["kind_icon"]
                    ["label" "label_description"]
                    ["kind"]
                  ];
                };
              };

              documentation = {
                auto_show = true;
                auto_show_delay_ms = 120;
                update_delay_ms = 50;
                window = {
                  min_width = 20;
                  max_width = 88;
                  max_height = 24;
                  border = "rounded";
                  scrollbar = true;
                };
              };

              ghost_text = {
                enabled = true;
                show_with_selection = true;
                show_without_selection = false;
                show_with_menu = true;
                show_without_menu = false;
              };
            };

            signature = {
              enabled = true;
              window = {
                border = "rounded";
              };
            };

            appearance = {
              use_nvim_cmp_as_default = false;
              nerd_font_variant = "mono";
            };

            sources = {
              default = ["lsp" "path" "snippets" "buffer"];
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
              dashboard.enabled = false;
            };
          };

          smart-splits.enable = true;
        };

        dashboard.alpha.enable = false;

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
              servers = ["basedpyright" "ruff"];
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

          gleam = {
            enable = true;
            lsp.enable = true;
            treesitter.enable = true;
          };
        };

        luaConfigRC.dashboard = ''
          local alpha = require("alpha")
          local dashboard = require("alpha.themes.dashboard")

          local logo = [[

          ███████╗██╗   ██╗ █████╗ ███████╗ ██████╗
          ██╔════╝██║   ██║██╔══██╗╚══███╔╝██╔═══██╗
          ███████╗██║   ██║███████║  ███╔╝ ██║   ██║
          ╚════██║██║   ██║██╔══██║ ███╔╝  ██║   ██║
          ███████║╚██████╔╝██║  ██║███████╗╚██████╔╝
          ╚══════╝ ╚═════╝ ╚═╝  ╚═╝╚══════╝ ╚═════╝

          ]]

          dashboard.section.header.val = vim.split(logo, "\n")

          dashboard.section.buttons.val = {
            dashboard.button("f", " " .. " Files",        "<cmd>FzfLua files<cr>"),
            dashboard.button("g", " " .. " Grep",         "<cmd>FzfLua live_grep<cr>"),
            dashboard.button("r", " " .. " Recent files", "<cmd>FzfLua oldfiles<cr>"),
            dashboard.button("o", " " .. " Oil float",    "<cmd>Oil --float<cr>"),
            dashboard.button("c", " " .. " Config",       "<cmd>e ~/.nixos/modules/dev/nvf/nvf.nix<cr>"),
            dashboard.button("q", " " .. " Quit",         "<cmd>qa<cr>"),
          }

          for _, button in ipairs(dashboard.section.buttons.val) do
            button.opts.hl = "AlphaButtons"
            button.opts.hl_shortcut = "AlphaShortcut"
          end

          dashboard.section.header.opts.hl = "AlphaHeader"
          dashboard.section.buttons.opts.hl = "AlphaButtons"
          dashboard.section.footer.opts.hl = "AlphaFooter"
          dashboard.opts.layout[1].val = 8

          alpha.setup(dashboard.opts)
        '';

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
                statusline = { "dashboard", "snacks_dashboard", "oil" },
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

          vim.g.opencode_opts = {}
          vim.o.autoread = true

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

          require("oil").setup({
            default_file_explorer = false,
            columns = { "icon" },
            delete_to_trash = true,
            skip_confirm_for_simple_edits = true,
            prompt_save_on_select_new_entry = true,
            view_options = {
              show_hidden = true,
            },
            float = {
              padding = 2,
              max_width = 100,
              max_height = 30,
              border = "rounded",
              win_options = {
                winblend = 0,
              },
            },
            keymaps = {
              ["<Esc>"] = { "actions.close", mode = "n" },
              ["q"] = "actions.close",
              ["<CR>"] = "actions.select",
              ["-"] = "actions.parent",
              ["_"] = "actions.open_cwd",
              ["g."] = "actions.toggle_hidden",
            },
          })

          require("fzf-lua").setup({
            winopts = {
              height = 0.80,
              width = 0.85,
              row = 0.35,
              col = 0.50,
              border = "rounded",
              preview = {
                border = "rounded",
                layout = "vertical",
                vertical = "down:45%",
              },
            },
            fzf_opts = {
              ["--layout"] = "reverse",
            },
            files = {
              cwd_prompt = false,
              git_icons = true,
            },
            grep = {
              git_icons = true,
            },
          })

          vim.keymap.set({ "n", "x" }, "<leader>oa", function()
            require("opencode").ask("@this: ", { submit = true })
          end, { desc = "Ask OpenCode" })

          vim.keymap.set({ "n", "x" }, "<leader>oo", function()
            require("opencode").select()
          end, { desc = "OpenCode actions" })

          vim.keymap.set({ "n", "t" }, "<leader>ot", function()
            require("opencode").toggle()
          end, { desc = "Toggle OpenCode" })

          vim.keymap.set({ "n", "x" }, "<leader>or", function()
            return require("opencode").operator("@this ")
          end, { expr = true, desc = "Send range to OpenCode" })

          vim.keymap.set("n", "<leader>ol", function()
            return require("opencode").operator("@this ") .. "_"
          end, { expr = true, desc = "Send line to OpenCode" })

          vim.opt.winborder = "rounded"

          vim.diagnostic.config({
            virtual_text = false,
            underline = true,
            signs = true,
            severity_sort = true,
            update_in_insert = false,
            float = {
              border = "rounded",
              source = "if_many",
              focusable = false,
            },
          })

          vim.api.nvim_create_autocmd("CursorHold", {
            callback = function()
              if vim.fn.mode() ~= "n" then
                return
              end

              local line = vim.api.nvim_win_get_cursor(0)[1] - 1
              local diags = vim.diagnostic.get(0, { lnum = line })
              if diags and #diags > 0 then
                vim.diagnostic.open_float(nil, {
                  scope = "cursor",
                  border = "rounded",
                  source = "if_many",
                  focusable = false,
                })
              end
            end,
          })

          local hover_opts = {
            border = "rounded",
            max_width = 88,
            max_height = 28,
          }

          vim.keymap.set("n", "K", function()
            vim.lsp.buf.hover(hover_opts)
          end, { desc = "LSP hover" })

          vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Goto definition" })
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Goto declaration" })
          vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "References" })
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Goto implementation" })
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename" })
          vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })

          vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Prev diagnostic" })
          vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
          vim.keymap.set("n", "<leader>xx", function()
            vim.diagnostic.open_float(nil, { border = "rounded", scope = "cursor" })
          end, { desc = "Line diagnostics" })

          vim.keymap.set("n", "<leader>ff", "<cmd>FzfLua files<cr>", { desc = "Find files" })
          vim.keymap.set("n", "<leader>fg", "<cmd>FzfLua live_grep<cr>", { desc = "Live grep" })
          vim.keymap.set("n", "<leader>fb", "<cmd>FzfLua buffers<cr>", { desc = "Buffers" })
          vim.keymap.set("n", "<leader>fr", "<cmd>FzfLua oldfiles<cr>", { desc = "Recent files" })
          vim.keymap.set("n", "<leader>fh", "<cmd>FzfLua help_tags<cr>", { desc = "Help tags" })
          vim.keymap.set("n", "<leader>fc", "<cmd>FzfLua commands<cr>", { desc = "Commands" })

          vim.keymap.set("n", "-", "<cmd>Oil --float<cr>", { desc = "Oil float" })
          vim.keymap.set("n", "<leader>o", "<cmd>Oil --float<cr>", { desc = "Oil float" })
          vim.keymap.set("n", "<leader>e", "<cmd>Oil --float<cr>", { desc = "Oil float" })

          vim.keymap.set("n", "<leader>gd", "<cmd>DiffviewOpen<cr>", { desc = "Diffview open" })
          vim.keymap.set("n", "<leader>gD", "<cmd>DiffviewClose<cr>", { desc = "Diffview close" })

          vim.keymap.set("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
          vim.keymap.set("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
          vim.keymap.set("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Close buffer" })

          vim.keymap.set("n", "<leader>li", "<cmd>LspInfo<cr>", { desc = "LSP info" })
          vim.keymap.set("n", "<leader>lh", "<cmd>checkhealth vim.lsp<cr>", { desc = "LSP health" })
        '';
      };
    };
  };
}
