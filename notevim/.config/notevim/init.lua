-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end

function VaultFilename()
  local fullPath = vim.fn.expand("%:p")
  if string.match(fullPath, "/home/ajche/Documents/AetherCloud/") then
    return fullPath:gsub("^/home/ajche/Documents/AetherCloud/", "", 1)
  else
    return fullPath
  end
end

vim.opt.rtp:prepend(lazypath)

-- settings
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.o.relativenumber = true
vim.o.wrap = false
vim.o.swapfile = false
vim.o.signcolumn = "yes"

vim.o.tabstop = 2
vim.o.expandtab = true
vim.o.softtabstop = 2
vim.o.shiftwidth = 2

vim.o.laststatus = 0      -- disable bottom statusline

vim.o.winbar = "%{%v:lua.VaultFilename()%}"

-- plugins
require("lazy").setup({
  spec = {
    -- import your plugins
    { import = "plugins" },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})
--require("image").enable() -- enable the plugin


-- rice
vim.diagnostic.config({ float = { border = "rounded" } })
vim.cmd("colorscheme kanagawa-wave")


-- keybinds

vim.keymap.set('n', '<leader>so', ':update<CR> :source<CR>')
vim.keymap.set('n', '<leader>fq', ':quitall!<CR>')
vim.keymap.set('n', '<leader>w', ':write<CR>')
vim.keymap.set('n', '<leader>la', ':Lazy<CR>')

vim.api.nvim_set_keymap('n', '<M-h>', '<C-w>h', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<M-l>', '<C-w>l', { noremap = true, silent = true })
--[[nnoremap <M-h> <C-w>h
nnoremap <M-j> <C-w>j
nnoremap <M-k> <C-w>k
nnoremap <M-l> <C-w>l--]]

-- Markview
vim.api.nvim_set_keymap("n", "<leader>r", "<CMD>Markview<CR>", { desc = "Toggles `markview` previews globally." });

require("markview.extras.checkboxes").setup({
  --- Default checkbox state(used when adding checkboxes).
  ---@type string
  default = "X",

  --- Changes how checkboxes are removed.
  ---@type
  ---| "disable" Disables the checkbox.
  ---| "checkbox" Removes the checkbox.
  ---| "list_item" Removes the list item markers too.
  remove_style = "disable",

  --- Various checkbox states.
  ---
  --- States are in sets to quickly change between them
  --- when there are a lot of states.
  ---@type string[][]
  states = {
    { " ", "/", "X" },
    { "<", ">" },
    { "?", "!", "*" },
    { '"' },
    { "l", "b", "i" },
    { "S", "I" },
    { "p", "c" },
    { "f", "k", "w" },
    { "u", "d" }
  }
})

-- Image
vim.keymap.set("n", "<leader>ci", function() require("image").clear() end)

-- Checkboxes
vim.keymap.set("n", "<leader>cc", ":Checkbox toggle<CR>")

-- Harpoon
vim.keymap.set('n', '<leader>h', require("harpoon.ui").toggle_quick_menu)
vim.keymap.set('n', '<leader>m', require("harpoon.mark").add_file)
vim.keymap.set('n', '<leader>n', require("harpoon.ui").nav_next)
vim.keymap.set('n', '<leader>p', require("harpoon.ui").nav_prev)

for i = 1, 9 do
  vim.keymap.set("n", "<leader>" .. i, function()
    require("harpoon.ui").nav_file(i)
  end, { desc = "Harpoon file " .. i })
end
-- NoNeckPain
vim.keymap.set('n', '<leader>cn', ":NoNeckPain<CR>")

-- Neotree
vim.keymap.set('n', '<leader>e', ':Neotree toggle<CR>:se rnu<CR>')

require("neo-tree").setup({
  filesystem = {
    components = {
      harpoon_index = function(config, node, _)
        local Marked = require("harpoon.mark")
        local path = node:get_id()
        local success, index = pcall(Marked.get_index_of, path)
        if success and index and index > 0 then
          return {
            text = string.format("%d ", index), -- <-- Add your favorite harpoon like arrow here
            highlight = config.highlight or "NeoTreeDirectoryIcon",
          }
        else
          return {
            text = "  ",
          }
        end
      end,
    },
    renderers = {
      file = {
        { "icon" },
        { "name",         use_git_status_colors = true },
        { "harpoon_index" }, --> This is what actually adds the component in where you want it
        { "diagnostics" },
        { "git_status",   highlight = "NeoTreeDimText" },
      },
    },
  },
  window = {
    width = 30,
  },
})

-- folds
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldtext = "getline(v:foldstart) "

local vim = vim
local api = vim.api
local M = {}
-- function to create a list of commands and convert them to autocommands
-------- This function is taken from https://github.com/norcalli/nvim_utils
function M.nvim_create_augroups(definitions)
  for group_name, definition in pairs(definitions) do
    api.nvim_command('augroup ' .. group_name)
    api.nvim_command('autocmd!')
    for _, def in ipairs(definition) do
      local command = table.concat(vim.tbl_flatten { 'autocmd', def }, ' ')
      api.nvim_command(command)
    end
    api.nvim_command('augroup END')
  end
end

local autoCommands = {
  -- other autocommands
  open_folds = {
    { "BufReadPost,FileReadPost", "*", "normal zR" }
  }
}

M.nvim_create_augroups(autoCommands)
