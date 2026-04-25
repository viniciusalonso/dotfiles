-- Bootstrap Lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({

  -- Tema
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("catppuccin-mocha")
    end,
  },

  -- Telescope (busca fuzzy)
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  -- Treesitter (syntax highlighting moderno)
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
  },

  -- LSP
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "pyright", "ts_ls" },
        automatic_installation = true,
      })

      vim.lsp.config("lua_ls", {})
      vim.lsp.config("pyright", {})
      vim.lsp.config("ts_ls", {})

      vim.lsp.enable({ "lua_ls", "pyright", "ts_ls" })
    end,
  },

  -- Autocomplete
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"]      = cmp.mapping.confirm({ select = true }),
          ["<Tab>"]     = cmp.mapping.select_next_item(),
          ["<S-Tab>"]   = cmp.mapping.select_prev_item(),
        }),
        sources = {
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
        },
      })
    end,
  },

  -- Explorador de arquivos
  {
    "stevearc/oil.nvim",
    config = function()
      require("oil").setup()
    end,
  },

  -- Lazygit dentro do Neovim
  {
    "kdheepak/lazygit.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  -- Status bar
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("lualine").setup({ options = { theme = "catppuccin" } })
    end,
  },

  -- Comentários rápidos (gcc / gc)
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  },

  -- Pares automáticos de () {} []
  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup()
    end,
  },

  -- NerdTree
{
  "preservim/nerdtree",
  config = function()
    vim.keymap.set("n", "<C-l>", ":NERDTreeToggle<CR>", { silent = true })
  end,
},

 -- Git NergTree
{
  "preservim/nerdtree",
  dependencies = {
    "Xuyuanp/nerdtree-git-plugin",
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    vim.keymap.set("n", "<C-l>", ":NERDTreeToggle<CR>", { silent = true })
  end,
},

-- Text objects customizados
{
  "kana/vim-textobj-user",
  config = function()
    vim.cmd([[
      call textobj#user#plugin('line', {
      \   '-': {
      \     'select-a-function': 'CurrentLineA',
      \     'select-a': 'al',
      \     'select-i-function': 'CurrentLineI',
      \     'select-i': 'il',
      \   },
      \ })
      function! CurrentLineA()
          normal! 0
          let head_pos = getpos('.')
          normal! $
          let tail_pos = getpos('.')
          return ['v', head_pos, tail_pos]
      endfunction
      function! CurrentLineI()
          normal! ^
          let head_pos = getpos('.')
          normal! g_
          let tail_pos = getpos('.')
          let non_blank_char_exists_p = getline('.')[head_pos[2] - 1] !~# '\s'
          return
                      \ non_blank_char_exists_p
                      \ ? ['v', head_pos, tail_pos]
                      \ : 0
      endfunction
    ]])
  end,
},

})
