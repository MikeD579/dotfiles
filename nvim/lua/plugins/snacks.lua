return {
  "folke/snacks.nvim",
  opts = function(_, opts)
    -- Ensure the nested tables exist before assigning
    opts.picker = opts.picker or {}
    opts.picker.sources = opts.picker.sources or {}
    opts.picker.sources.explorer = vim.tbl_deep_extend("force", opts.picker.sources.explorer or {}, {
      hidden = false,
      ignored = true,
    })
  end,
}
