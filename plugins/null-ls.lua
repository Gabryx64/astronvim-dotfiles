return {
  "jose-elias-alvarez/null-ls.nvim",
  opts = function(_, config)
    local null_ls = require "null-ls"

    local CompletionItemKind = vim.lsp.protocol.CompletionItemKind
    local kinds = {
      d = CompletionItemKind.Keyword,
      f = CompletionItemKind.Function,
      t = CompletionItemKind.Struct,
      v = CompletionItemKind.Variable,
    }

    local nim = {
      method = null_ls.methods.COMPLETION,
      filetypes = { "nim" },
      generator = {
        async = true,
        fn = function(_, done)
          vim.fn["nim#suggest#sug#GetAllCandidates"](function(_, candidates)
            local items = vim.tbl_map(
              function(candidate)
                return {
                  kind = kinds[candidate.kind] or CompletionItemKind.Text,
                  label = candidate.word,
                  documentation = candidate.info,
                }
              end,
              candidates
            )
            done { { items = items } }
          end)
        end,
      },
    }

    -- null_ls.register(code_clippy)

    -- Check supported formatters and linters
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
    config.sources = {
      -- Set a formatter
      -- null_ls.builtins.formatting.stylua,
      null_ls.builtins.formatting.prettier,
      nim,
    }

    return config
  end,
}
