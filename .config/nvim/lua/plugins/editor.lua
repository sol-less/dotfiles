return {
  -- 1. Treesitter: Better Syntax Highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function() 
      -- Use the direct setup call
      local configs = require("nvim-treesitter.configs")
      configs.setup({
        ensure_installed = { "lua", "vim", "vimdoc", "javascript", "python", "bash", "markdown" },
        highlight = { 
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = { enable = true },
      })
    end
  },

  -- 2. Autocompletion (Same as before, keep this part)
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
        }),
      })
    end,
  },
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({
        view = {
          width = 30,
          side = "left",
        },
        renderer = {
          icons = {
            show = { file = true, folder = true, git = true },
          },
        },
      })
      -- Toggle with Ctrl+n like a pro
      vim.keymap.set('n', '<C-n>', ':NvimTreeToggle<CR>')
    end,
  },

  -- 2. Status Line (The bottom bar)
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require('lualine').setup({
        options = {
          theme = 'base16', -- This will sync with your Matugen colors!
	  globalstatus = true,
          section_separators = '',
          component_separators = '',
        }
      })
    end,
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      local autopairs = require("nvim-autopairs")
      
      autopairs.setup({
        check_ts = true, -- Use Treesitter to be smarter
        disable_filetype = { "TelescopePrompt" },
      })

      -- If you want brackets to be added when you select a completion from nvim-cmp
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local cmp = require("cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },
	{
    "goolord/alpha-nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")

      -- Set your header (You can use ASCII art here)
      dashboard.section.header.val = {
        "    ███╗   ██╗██╗   ██╗██╗███╗   ███╗    ",
        "    ████╗  ██║██║   ██║██║████╗ ████║    ",
        "    ██╔██╗ ██║██║   ██║██║██╔████╔██║    ",
        "    ██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║    ",
        "    ██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║    ",
        "    ╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝    ",
      }

      -- Custom Menu Buttons
      dashboard.section.buttons.val = {
        dashboard.button("n", "  New file", ":ene <BAR> startinsert <CR>"),
        dashboard.button("o", "󰈞  Recent files", ":Telescope oldfiles <CR>"),
        dashboard.button("c", "  Config", ":e ~/.config/nvim/init.lua <CR>"),
        dashboard.button("q", "󰅚  Quit", ":qa<CR>"),
      }

      alpha.setup(dashboard.config)
    end
  },
}
