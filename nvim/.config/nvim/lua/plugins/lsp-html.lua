-- ~/.config/nvim/lua/plugins/lsp-html.lua
return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      html = {
        filetypes = { "html", "htmldjango" },
      },
    },
  },
}
