return {
  -- catppuccin theme
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("catppuccin-mocha")
    end,
  },

  -- treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      ensure_installed = { "c", "lua", "python", "bash", "vim" },
      highlight = { enable = true },
      indent = { enable = true },
    },
  },

  -- telescope
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "Telescope",
    opts = {
      defaults = {
        file_ignore_patterns = { "node_modules", "%.git", "^ext/", "^build/", "^bin/", "^generated/" },
      },
    },
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>",  desc = "Find Buffers" },
    },
  },

  -- mini.files
  {
    "nvim-mini/mini.files",
    version = "*",
    keys = {
      {
        "<leader>e",
        function()
          require("mini.files").open(
            vim.api.nvim_buf_get_name(0),
            false
          )
        end,
        desc = "Browse files",
      },
    },
    opts = {
      mappings = {
        close = "q",
        go_in = "l",
        go_out = "h",
      },
    },
  },

  -- lsp + mason
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = { "clangd", "lua_ls" },
      })
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
      vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Find references" })
      vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover" })
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename" })
    end,
  },

  -- nvim-lint
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPost", "BufNewFile" },
    config = function() 
      local lint = require("lint")
      lint.linters_by_ft = {
        sh = { "shellcheck" },
        bash = { "shellcheck" },
      }
      
      vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost" }, {
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },

  -- autocomplete
  {
    "saghen/blink.cmp",
    dependencies = {
      "saghen/blink.lib",
      "nvim-treesitter/nvim-treesitter",
    },
    build = function()
      require("blink.cmp").build():pwait()
    end;
    event = "InsertEnter",
    opts = {
      keymap = { preset = "super-tab" }, -- Tab to select, Enter to confirm
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },
      completion = {
        documentation = { auto_show = false },
        accept = {
          auto_brackets = { enabled = true },
        },
      },
      appearance = {
        use_nvim_cmp_as_default = true,
      },
    },
  },

  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {
      sections = {
        lualine_a = { "mode" },
      },
    },
  },
}

