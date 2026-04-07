vim.g.mapleader = " "

vim.keymap.set('n', '<leader>o', ':update<CR> :source<CR>')
vim.keymap.set('n', '<leader>w', ':write<CR>')
vim.keymap.set('n', '<leader>q', ':quitall<CR>')
vim.keymap.set('n', '<leader>fq', ':quitall!<CR>')
vim.keymap.set('n', '<leader>e', ':Oil<CR>')
vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format)
vim.keymap.set('n', '<leader>ch', ':noh<CR>')
vim.keymap.set('n', '<leader>la', ':Lazy<CR>')

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })

vim.keymap.set('n', '<leader>er', vim.diagnostic.open_float)
vim.keymap.set("n", "<leader>dj", vim.lsp.buf.definition, { desc = "Go to definition" })

vim.keymap.set("n", "<leader>dh", require("pretty_hover").hover)

vim.keymap.set('n', '<leader>h', require("harpoon.ui").toggle_quick_menu)
vim.keymap.set('n', '<leader>m', require("harpoon.mark").add_file)
vim.keymap.set('n', '<leader>n', require("harpoon.ui").nav_next)
vim.keymap.set('n', '<leader>p', require("harpoon.ui").nav_prev)

for i = 1, 9 do
  vim.keymap.set("n", "<leader>" .. i, function()
    require("harpoon.ui").nav_file(i)
  end, { desc = "Harpoon file " .. i })
end

