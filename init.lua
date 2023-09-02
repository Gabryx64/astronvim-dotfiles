return {
  -- Configure AstroNvim updates
  updater = {
    remote = "origin", -- remote to use
    channel = "stable", -- "stable" or "nightly"
    version = "latest", -- "latest", tag name, or regex search like "v1.*" to only do updates before v2 (STABLE ONLY)
    branch = "nightly", -- branch name (NIGHTLY ONLY)
    commit = nil, -- commit hash (NIGHTLY ONLY)
    pin_plugins = nil, -- nil, true, false (nil will pin plugins on stable only)
    skip_prompts = false, -- skip prompts about breaking changes
    show_changelog = true, -- show the changelog after performing an update
    auto_quit = false, -- automatically quit the current session after a successful update
    remotes = { -- easily add new remotes to track
      --   ["remote_name"] = "https://remote_url.come/repo.git", -- full remote url
      --   ["remote2"] = "github_user/repo", -- GitHub user/repo shortcut,
      --   ["remote3"] = "github_user", -- GitHub user assume AstroNvim fork
    },
  },
  -- Set colorscheme to use
  colorscheme = "gruvbox-baby",
  -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
  diagnostics = {
    virtual_text = true,
    underline = true,
  },
  lsp = {
    -- customize lsp formatting options
    formatting = {
      -- control auto formatting on save
      format_on_save = {
        enabled = true, -- enable or disable format on save globally
        allow_filetypes = { -- enable format on save for specified filetypes only
          -- "go",
        },
        ignore_filetypes = { -- disable format on save for specified filetypes
          -- "python",
        },
      },
      disabled = { -- disable formatting capabilities for the listed language servers
        -- "sumneko_lua",
      },
      timeout_ms = 1000, -- default format timeout
      -- filter = function(client) -- fully override the default formatting function
      --   return true
      -- end
    },
    -- enable servers that you already have installed without mason
    servers = {
      -- "pyright"
      "dartls",
    },
    setup_handlers = {
      dartls = function(_, opts) require("flutter-tools").setup { lsp = opts } end,
    },
    config = {
      dartls = {
        color = {
          enabled = true,
        },
        settings = {
          showTodos = true,
          completeFunctionCalls = true,
        },
      },
      denols = function(opts)
        opts.root_dir = require("lspconfig.util").root_pattern("deno.json", "deno.jsonc")
        return opts
      end,
      tsserver = function(opts)
        opts.root_dir = require("lspconfig.util").root_pattern "package.json"
        return opts
      end,
    },
  },
  -- Configure require("lazy").setup() options
  lazy = {
    defaults = { lazy = true },
    performance = {
      rtp = {
        -- customize default disabled vim plugins
        disabled_plugins = { "tohtml", "gzip", "matchit", "zipPlugin", "netrwPlugin", "tarPlugin", "matchparen" },
      },
    },
  },
  -- This function is run last and is a good place to configuring
  -- augroups/autocommands and custom filetypes also this just pure lua so
  -- anything that doesn't fit in the normal config locations above can go here
  polish = function()
    local config = require "gruvbox-baby.config"
    local c = require("gruvbox-baby.colors").config()
    vim.g.gruvbox_baby_highlights = {
      ["@keyword.if"] = { fg = c.red, style = config.keyword_style },
      ["@keyword.switch"] = { fg = c.red, style = config.keyword_style },
      ["@keyword.while"] = { fg = c.red, style = config.keyword_style },
      ["@keyword.do"] = { fg = c.red, style = config.keyword_style },
      ["@keyword.for"] = { fg = c.red, style = config.keyword_style },
    }

    vim.env.PATH = "/home/gabry/.ghcup/bin:/home/gabry/.nimble/bin:" .. vim.env.PATH
    vim.cmd "cd ~/Programming/"
    vim.o.updatetime = 150
    vim.diagnostic.config {
      virtual_text = false,
      underline = true,
      signs = true,
    }
    vim.cmd "autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})"
    local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "scala", "sbt" },
      callback = function() require("metals").initialize_or_attach {} end,
      group = nvim_metals_group,
    })

    function Ide(_)
      vim.cmd "Neotree"
      vim.cmd "wincmd l"
      vim.cmd "split"
      vim.cmd "terminal"
      vim.cmd "wincmd k"
      vim.cmd "resize 50"
    end

    vim.api.nvim_create_user_command("Ide", Ide, {})
  end,
}
