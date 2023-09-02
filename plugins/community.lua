local function import(pkg) return { import = "astrocommunity." .. pkg } end
local function lang(pkg) return import("pack." .. pkg) end
local function syntax(pkg) return import("syntax." .. pkg) end
local function test(pkg) return import("test." .. pkg) end
local function preview(pkg) return import("markdown-and-latex." .. pkg) end
local function util(pkg) return import("utility." .. pkg) end
local function git(pkg) return import("git." .. pkg) end
local function ed(pkg) return import("editing-support." .. pkg) end
local function media(pkg) return import("media." .. pkg) end
local function color(pkg) return import("color." .. pkg) end
local function colorscheme(pkg) return import("colorscheme." .. pkg) end

return {
  "AstroNvim/astrocommunity",

  -- Programming
  lang "json",
  lang "lua",
  lang "markdown",
  lang "php",
  lang "python",
  lang "rust",
  lang "svelte",
  lang "typescript",
  lang "yaml",
  syntax "hlargs-nvim",
  ed "rainbow-delimiters-nvim",
  ed "nvim-regexplainer",
  git "neogit",
  test "neotest",
  preview "glow-nvim",

  -- Looks
  util "neodim",
  util "noice-nvim",
  ed "todo-comments-nvim",
  media "presence-nvim",
  media "pets-nvim",
  color "tint-nvim",
  colorscheme "gruvbox-baby",

  -- Configs
  {
    "noice.nvim",
    config = function()
      vim.api.nvim_set_hl(0, "TransparentCmdline", { fg = 0xb8bb26 })
      vim.api.nvim_set_hl(0, "TransparentInput", { fg = 0x8ec07c })
      vim.api.nvim_set_hl(0, "TransparentLua", { fg = 0x83a598 })
      vim.api.nvim_set_hl(0, "TransparentFilter", { fg = 0xbdae93 })
      vim.api.nvim_set_hl(0, "TransparentHelp", { fg = 0xfe8019 })
      vim.api.nvim_set_hl(0, "TransparentSearch", { fg = 0xfabd2f })

      local noice_override_cmd_types = {
        Cmdline = "TransparentCmdline",
        Input = "TransparentInput",
        Lua = "TransparentLua",
        Filter = "TransparentFilter",
        Substitute = "TransparentSearch",
        Help = "TransparentHelp",
        Search = "TransparentSearch",
      }

      vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorder", { link = "DevIconLua" })
      vim.api.nvim_set_hl(0, "NoiceCmdlineIcon", { link = "DevIconLua" })

      for type, hl in pairs(noice_override_cmd_types) do
        vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorder" .. type, { link = hl })
        vim.api.nvim_set_hl(0, "NoiceCmdlineIcon" .. type, { link = hl })
      end
      vim.api.nvim_set_hl(0, "NoiceConfirmBorder", { link = "DevIconLua" })

      local Cmdlines = {
        Normal = "ABC",
        FloatBorder = "XYZ",
      }
      local Searches = {
        Normal = "OtherStuff",
        FloatBorder = "OtherBorder",
      }

      require("noice").setup {
        lsp = {
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
        },
        cmdline = {
          format = {
            cmdline = { pattern = "^:", winhighlight = Cmdlines },
            search_down = { pattern = "^/", winhighlight = Searches },
            search_up = { pattern = "^%?", winhighlight = Searches },
          },
        },
        views = {
          cmdline_popup = {
            win_options = {
              winhighlight = Cmdlines,
            },
          },
        },
        presets = {
          command_palette = true,
          long_message_to_split = true,
          inc_rename = false,
          lsp_do_order = false,
        },
      }
    end,
  },
  {
    "pets.nvim",
    opts = {
      popup = {
        width = "100%",
      },
    },
  },
}
