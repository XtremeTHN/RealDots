require("nvchad.configs.lspconfig").defaults()

local servers = { "html", "cssls", "pylsp", "vala_ls", "mesonlsp", "blueprint-gtk" }
local lsp = vim.lsp.config

lsp["blueprint-gtk"] = {
  cmd = { "blueprint-compiler", "lsp" },
  filetypes = { "blp", "blueprint", "x-blueprint" },
  documentSelector = {
    {
      scheme = "file",
      language = "blueprint-gtk",
    },
  },
}

vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers
