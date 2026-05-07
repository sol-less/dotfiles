return {
  {
    "RRethy/nvim-base16",
    lazy = false,
    priority = 1000,
    config = function()
      -- Try to load the shell default, fallback to a standard one if it fails
      local status, _ = pcall(vim.cmd, "colorscheme base16-shell_default")
      if not status then
          -- Fallback if the dynamic name isn't generated yet
          vim.cmd("colorscheme base16-tomorrow-night")
      end

      -- Transparency logic
      local function clear_bg()
        local highlights = {
          "Normal", "NormalNC", "LineNr", "Folded", "NonText",
          "SpecialKey", "VertSplit", "SignColumn", "EndOfBuffer",
          "StatusLine", "StatusLineNC", "Pmenu", "NormalFloat", "FloatBorder",
	  "NvimTreeNormal", "NvimTreeNormalNC", "NvimTreeWinSeparator",
 	  "NvimTreeFolderName", "NvimTreeOpenedFolderName", "NvimTreeEmptyFolderName",
	  "NvimTreeIndentMarker", "NvimTreeVertSplit",
        }
        for _, group in ipairs(highlights) do
          vim.api.nvim_set_hl(0, group, { bg = "none", ctermbg = "none" })
        end
	vim.api.nvim_set_hl(0, "EndOfBuffer", { fg = 'none', bg = 'none' })
      end

      clear_bg()
      
      -- Keep it transparent even if you swap themes later
      vim.api.nvim_create_autocmd("ColorScheme", {
        callback = clear_bg,
      })
    end,
  },
}
