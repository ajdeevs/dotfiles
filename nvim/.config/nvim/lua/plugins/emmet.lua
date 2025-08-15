-- ~/.config/nvim/lua/plugins/emmet.lua
return {
  "mattn/emmet-vim",
  ft = { "html", "css", "javascriptreact" },
  init = function()
    vim.g.user_emmet_leader_key = "<C-y>"
  end,
}
