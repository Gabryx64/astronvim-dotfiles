-- You can also add or configure plugins by creating files in this `plugins/` folder
-- Here are some examples:

---@type LazySpec
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
    "puremourning/vimspector",
    lazy = false,
    init = function()
      vim.cmd [[
        let g:vimspector_sidebar_width = 65
        let g:vimspector_bottombar_height = 15

        nmap <C-F9> <cmd>call vimspector#Launch()<cr>
        nmap <C-F5> <cmd>call vimspector#StepOver()<cr>
        nmap <C-F8> <cmd>call vimspector#Reset()<cr>
        nmap <C-F11> <cmd>call vimspector#StepOver()<cr>
        nmap <C-F12> <cmd>call vimspector#StepOut()<cr>
        nmap <C-F10> <cmd>call vimspector#StepInto()<cr>
        nmap Db <cmd>call vimspector#ToggleBreakpoint()<cr>
        nmap Dw <cmd>call vimspector#AddWatch()<cr>
        nmap De <cmd>call vimspector#Evaluate()<cr>
      ]]
    end,
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

  "andweeb/presence.nvim",
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function() require("lsp_signature").setup() end,
  },

  -- customize alpha options
  {
    "goolord/alpha-nvim",
    opts = function(_, opts)
      -- customize the dashboard header
      opts.section.header.val = {
        "  __",
        " /_ \\",
        "   \\ \\",
        "    \\ \\",
        "     \\ \\",
        "     /  \\",
        "    / /\\ \\",
        "   / /  \\ \\",
        "  / /    \\ \\",
        " / /      \\ \\",
        "/_/        \\_\\",
      }
      return opts
    end,
  },
  { "L3MON4D3/LuaSnip", enabled = false },
  {
    "rcarriga/nvim-notify",
    opts = {
      background_colour = "#000000",
    },
  },
  {
    "neovim/nvim-lspconfig",
    init = function()
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.offsetEncoding = { "utf-16" }
      require("lspconfig").clangd.setup {
        capabilities = capabilities,
      }
    end,
  },
  {
    "EthanJWright/vs-tasks.nvim",
    dependencies = {
      "nvim-lua/popup.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
  },
  {
    "mlochbaum/BQN",
    config = function(plugin)
      vim.opt.rtp:append(plugin.dir .. "/editor/vim")
      require("lazy.core.loader").packadd(plugin.dir .. "/editors/vim")
    end,
    init = function(plugin) require("lazy.core.loader").ftdetect(plugin.dir .. "/editors/vim") end,
  },
  {
    "amitds1997/remote-nvim.nvim",
    version = "*", -- Pin to GitHub release
    dependencies = {
      "nvim-lua/plenary.nvim", -- For standard functions
      "MunifTanjim/nui.nvim", -- To build the plugin UI
      "nvim-telescope/telescope.nvim", -- For picking b/w different remote methods
    },
    config = true,
  }
}
