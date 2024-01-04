-- Maximize and Restore Current Window
return {
  "szw/vim-maximizer",
  event = 'VeryLazy',
  keys = {
    { "<leader>m", "<cmd>MaximizerToggle<CR>", desc = "Maximize/minimize a split" },
  },
}
