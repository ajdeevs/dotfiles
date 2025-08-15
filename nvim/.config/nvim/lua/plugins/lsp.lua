-- ~/.config/nvim/lua/plugins/lsp-tsserver.lua
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        tsserver = {},
      },
    },
  },
}
