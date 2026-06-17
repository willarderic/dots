vim.o.number = true
vim.o.relativenumber = true
vim.o.wrap = false
vim.o.tabstop = 4
vim.o.shiftwidth = 4
-- removes .swp file that is created when editing
vim.o.swapfile = false
vim.g.mapleader = " "
-- Optional: Prevent space from triggering itself in normal mode
vim.keymap.set("n", " ", " ", { silent = true, remap = false })
vim.o.winborder = "rounded"
vim.o.ignorecase = true

-- some basic vim key mappings
vim.keymap.set("n", "<leader>w", ":write<CR>")
vim.keymap.set("n", "<leader>q", ":quit<CR>")
vim.keymap.set("n", "<leader><Tab>", ":tabnext<CR>")

vim.keymap.set("n", "<C-J>", "<C-W>j", { noremap = false })
vim.keymap.set("n", "<C-K>", "<C-W>k", { noremap = false })
vim.keymap.set("n", "<C-H>", "<C-W>h", { noremap = false })
vim.keymap.set("n", "<C-L>", "<C-W>l", { noremap = false })

vim.pack.add({
	{ src = "https://github.com/echasnovski/mini.pick" },
	{ src = "https://github.com/sh1Nome/mini-pick-preview.nvim" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/mason-org/mason-lspconfig.nvim" },
	{ src = "https://github.com/neanias/everforest-nvim" },
})

-- LSP stuff
-- mason lets me download LSPs individually by using :Mason
-- The LSP server needs to be downloaded to be used in vim.lsp.enable
require("mason").setup()
require("mason-lspconfig").setup()
vim.lsp.enable({ "lua_ls", "rust_analyzer", "clangd" })

vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "gr", vim.lsp.buf.references)
vim.keymap.set("n", "gt", vim.lsp.buf.type_definition)
vim.keymap.set("n", "gi", vim.lsp.buf.implementation)
vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format)

-- Change omni-complete keybind
vim.keymap.set("i", "<C-Space>", "<C-x><C-o>")
-- Smart Tab completion mapping
vim.keymap.set("i", "<Tab>", function()
	if vim.fn.pumvisible() == 1 then
		return "<C-n>"
	else
		return "<Tab>"
	end
end, { expr = true, silent = true })

-- Confirm selection
vim.keymap.set("i", "<CR>", function()
	if vim.fn.pumvisible() == 1 then
		return "<C-y>"
	else
		return "<CR>"
	end
end, { expr = true, silent = true })

-- search files
-- C-t while searching to open file in new tab!
require("mini.pick").setup()
require("mini-pick-preview").setup()
vim.keymap.set("n", "<leader>sf", ":Pick files<CR>")

-- colorscheme
vim.cmd("colorscheme everforest")
