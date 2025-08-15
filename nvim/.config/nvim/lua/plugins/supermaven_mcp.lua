return {
  "supermaven-inc/supermaven-nvim",
  opts = function(_, opts)
    opts.mcp_servers = opts.mcp_servers or {}

    table.insert(opts.mcp_servers, {
      name = "Avelanche",
      cmd = { "node", "~/Downloads/avalanche-mcp-tools/build/index.js" },
      filetypes = { "python", "lua", "javascript", "typescript" },
    })

    return opts
  end,
}
