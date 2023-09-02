return {
  {
    "alaviss/nim.nvim",
    ft = { "nim" },
  },
  {
    "ShinKage/idris2-nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    ft = { "idr" },
  },
  {
    "Exafunction/codeium.vim",
    lazy = false,
  },
  {
    "ahmedkhalf/jupyter-nvim",
    build = ":UpdateRemotePlugins",
    ft = "ipynb",
  },
  {
    "lukas-reineke/lsp-format.nvim",
    lazy = false,
  },
  {
    "iamcco/markdown-preview.nvim",
    build = function() vim.fn["mkdp#util#install"]() end,
    ft = "md",
  },
  {
    "akinsho/flutter-tools.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim",
      "lukas-reineke/lsp-format.nvim",
    },
    opts = function()
      return {
        lsp = {
          on_attach = require("lsp-format").on_attach,
        },
      }
    end,
    ft = "dart",
  },
  {
    "scalameta/nvim-metals",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    build = function()
      local metals_config = require("metals").bare_config()
      metals_config.on_attach = function(_, _)
        require("metals").setup_dap()
        vim.cmd "autocmd BufWritePost <buffer> lua vim.lsp.buf.formatting_sync()"
      end
      metals_config.init_options.statusBarProvider = "on"
    end,
  },
  {
    "xiyaowong/transparent.nvim",
    as = "transparent",
    opts = {
      groups = { -- table: default groups
        "Normal",
        "NormalNC",
        "Comment",
        "Constant",
        "Special",
        "Identifier",
        "Statement",
        "PreProc",
        "Type",
        "Underlined",
        "Todo",
        "String",
        "Function",
        "Conditional",
        "Repeat",
        "Operator",
        "Structure",
        "LineNr",
        "NonText",
        "SignColumn",
        "CursorLineNr",
        "EndOfBuffer",
      },
      extra_groups = { -- table/string: additional groups that should be cleared
        -- In particular, when you set it to 'all', that means all available groups

        -- example of akinsho/nvim-bufferline.lua
        "BufferLineTabClose",
        "BufferlineBufferSelected",
        "BufferLineFill",
        "BufferLineBackground",
        "BufferLineSeparator",
        "BufferLineIndicatorSelected",
      },
      exclude_groups = {}, -- table: groups you don't want to clear
    },
    lazy = false,
  },
}
