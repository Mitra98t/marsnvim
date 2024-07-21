vim.g.mapleader = " "

local keymap = vim.keymap

-- utils
keymap.set("i", "jj", "<ESC>", { desc = "Exit insert mode with jk" })
keymap.set({ "i", "n", "v" }, "<C-s>", "<cmd>w<CR>", { desc = "Write buffer" })
keymap.set("n", "<C-q>", "<cmd>q<CR>", { desc = "Quit nvim" })
-- FIX: toggle word wrap

--[[
keymap.set("n", "<leader>uw", function()
	vim.opt.wrap = not vim.opt.wrap
end, { desc = "Toggle word wrap" })
]]
--

