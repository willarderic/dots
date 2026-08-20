vim.o.number = true
vim.o.relativenumber = false
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
vim.o.scrolloff = 10

-- prevent the built-in vim.lsp.completion autotrigger from selecting the first item
vim.opt.completeopt = { "menuone", "noselect", "popup" }

-- some basic vim key mappings
vim.keymap.set("n", "<leader>w", ":write<CR>")
vim.keymap.set("n", "<leader>q", ":quit<CR>")
vim.keymap.set("n", "<leader><Tab>", ":tabnext<CR>")

-- Switch between splits with Ctrl+Key instead of C+W followed by key
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
require("mason-lspconfig").setup {
  ensure_installed = { "lua_ls", "rust_analyzer", "clangd", "gopls" },
}

vim.diagnostic.config({ virtual_text = true })

-- from: https://blog.viktomas.com/graph/neovim-native-built-in-lsp-autocomplete/ but changed to work with nvim 12 lsp 
-- vim.lsp.config("gopls", {
-- 	on_attach = function(client, bufnr)
--       vim.lsp.completion.enable(true, client.id, bufnr, {
-- 		autotrigger = true,
-- 		convert = function(item)
--           return { abbr = item.label:gsub("%b()", "") }
-- 		end,
--       })
--       vim.keymap.set("i", "<C-space>", vim.lsp.completion.get, { desc = "trigger autocompletion" })
--     end
-- })
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if client ~= nil and client:supports_method("textDocument/completion") then
			vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
		end
	end,
})

-- LSP allows for nice movement. 
--  - gd is go to definition
--	- gr is go to references
--	- gt is go to type definition
--	- gi is go to implementation
--	- grn (automatically configured) is a refactor of a name
--	- <space> then l then f formats the current file.
--	not part of LSP, BUT C-o in normal mode takes you back to previous location
vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "gr", vim.lsp.buf.references)
vim.keymap.set("n", "gt", vim.lsp.buf.type_definition)
vim.keymap.set("n", "gi", vim.lsp.buf.implementation)
vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format)

-- search files
-- C-t while searching to open file in new tab!
require("mini.pick").setup()
require("mini-pick-preview").setup()
-- space then s then f lists a popup with fuzzy search of files
vim.keymap.set("n", "<leader>sf", ":Pick files<CR>")

-- colorscheme
vim.cmd("colorscheme everforest")


-- opens up file explorer to the left
vim.g.netrw_liststyle = 3
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
vim.g.netrw_browse_split = 0
vim.g.netrw_altfile = 1

vim.keymap.set("n", "<leader>e", ":Lexplore<cr>", { silent = true })

-- highlight yanked selection
vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
	pattern = "*",
	desc = "highlight selection on yank",
	callback = function()
		vim.highlight.on_yank({ timeout = 100, visual = true })
	end,
})
