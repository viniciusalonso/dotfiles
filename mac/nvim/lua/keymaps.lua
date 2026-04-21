local map = vim.keymap.set

vim.g.mapleader = " "  -- Space como leader

-- Navegação entre splits
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- Mover linhas selecionadas
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

-- Telescope
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>")
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>")
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>")

-- Oil (explorador de arquivos)
-- map("n", "<leader>e", "<cmd>Oil<cr>")

-- NErdtree


-- Lazygit
map("n", "<leader>gg", "<cmd>LazyGit<cr>")

-- LSP (ativados quando um LSP conecta)
map("n", "gd", vim.lsp.buf.definition)
map("n", "K", vim.lsp.buf.hover)
map("n", "<leader>rn", vim.lsp.buf.rename)
map("n", "<leader>ca", vim.lsp.buf.code_action)
map("n", "<leader>f", vim.lsp.buf.format)

-- Previous vim
map("n", "<C-c>", "<cmd>q<cr>")
map("n", "<leader><leader>", "<cmd>w<cr>")
