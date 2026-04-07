require("config.options")
require("config.lazy")
vim.lsp.enable({"lua_ls", "basedpyright", "ruff", "clangd", "dartls"})
require("config.keybinds")

vim.opt.clipboard = "unnamedplus"

vim.o.tabstop = 2 -- A TAB character looks like 2 spaces
vim.o.expandtab = true -- Pressing the TAB key will insert spaces instead of a TAB character
vim.o.softtabstop = 2 -- Number of spaces inserted instead of a TAB character
vim.o.shiftwidth = 2 -- Number of spaces inserted when indenting

vim.cmd("colorscheme kanagawa-wave")


vim.cmd("highlight Normal guibg=#1F1F28")

