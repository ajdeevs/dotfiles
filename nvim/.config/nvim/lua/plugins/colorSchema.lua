-- ~/.config/nvim/lua/plugins/init.lua
return {
  -- your other plugins...

  {
    "cdmill/neomodern.nvim",
    lazy = false,
    priority = 999,
    config = function()
      require("neomodern").setup({
        -- optional configuration here
      })
      require("neomodern").load()
    end,
  },

  -- more plugins...
}
