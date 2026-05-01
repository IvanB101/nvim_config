return {
  "navarasu/onedark.nvim",
  priority = 1000, -- make sure to load this before all the other start plugins
  enable = false,
  config = function()
    require('onedark').setup {
      style = 'deep'
    }
    require('onedark').load()
  end
}
