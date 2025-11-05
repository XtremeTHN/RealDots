local options = {
  formatters = {
    blpfmt = {
      command = "blueprint-compiler",
      args = { "format", "--fix", "$FILENAME" },
      stdin = false,
      tmpfile_format = ".conform.$RANDOM.$FILENAME",
    },
  },
  formatters_by_ft = {
    lua = { "stylua" },
    py = { "ruff" },
    blueprint = { "blpfmt" },
    -- css = { "prettier" },
    -- html = { "prettier" },
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

return options
