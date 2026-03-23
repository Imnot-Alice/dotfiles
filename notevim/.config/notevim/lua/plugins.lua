--- Gets icon from a parsed heading item.
---@param item markview.parsed.markdown.atx
---@return string
local function get_icon(_, item)
  if not item or not item.levels then
    return "";
  end

  local output = "󰫢 [";

  for l, level in ipairs(item.levels) do
    if level ~= 0 then
      output = output .. level .. (l ~= #item.levels and "." or "");
    end
  end

  return output .. "] ";
end

return {

  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate'
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = true,
  },
  {
    'nvim-mini/mini.nvim', version = false
  },
  {
    'ThePrimeagen/harpoon', dependencies = { 'nvim-lua/plenary.nvim' }
  },
  {
    "OXY2DEV/markview.nvim",
    lazy = false,
    -- Completion for `blink.cmp`
    dependencies = { "saghen/blink.cmp" },
    opts = {
      preview = {
        icon_provider = "mini",
        preview = { enable = false }
      },
      markdown = {
        headings = {
          heading_1 = { icon_hl = "@markup.link", icon = get_icon },
          heading_2 = { icon_hl = "@markup.link", icon = get_icon },
          heading_3 = { icon_hl = "@markup.link", icon = get_icon }
        }
      }
    }
  },
    {
    "HakonHarnes/img-clip.nvim",
    event = "VeryLazy",
    opts = {
      -- or leave it empty to use the default settings
    },
    keys = {
      -- suggested keymap
      { "<leader>p", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" },
    }
  },
    {
    '2kabhishek/nerdy.nvim',
    dependencies = {
      'folke/snacks.nvim',
    },
    cmd = 'Nerdy',
    opts = {
      max_recents = 30,          -- Configure recent icons limit
      copy_to_clipboard = false, -- Copy glyph to clipboard instead of inserting
      copy_register = '+',       -- Register to use for copying (if `copy_to_clipboard` is true)
    },
    keys = {
      { '<leader>in', ':Nerdy recents<CR>', desc = "Browse nerd icons" },
    }
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons", -- optional, but recommended
    },
    opts = {
      event_handlers = {
        {
          event = "neo_tree_buffer_enter",
          handler = function()
            vim.opt_local.relativenumber = true
          end,
        }
      },
    },
    lazy = false, -- neo-tree will lazily load itself
},
{
  "shortcuts/no-neck-pain.nvim", version = "*"
},
{
    "hedyhli/outline.nvim",
    lazy = true,
    cmd = { "Outline", "OutlineOpen" },
    keys = {
      { "<leader>o", "<cmd>Outline<CR>", desc = "Toggle Outline" },
    },
    opts = {
      symbol_folding = {
        autofold_depth = false,
      },
    },
  },
  {
  'jghauser/follow-md-links.nvim'
  },
  {
    'saghen/blink.cmp',
    -- optional: provides snippets for the snippet source
    dependencies = { 'rafamadriz/friendly-snippets' },

    -- use a release tag to download pre-built binaries
    version = '1.*',
    -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'cargo build --release',
    -- If you use nix, you can build from source using latest nightly rust with:
    -- build = 'nix run .#build-plugin',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
      -- 'super-tab' for mappings similar to vscode (tab to accept)
      -- 'enter' for enter to accept
      -- 'none' for no mappings
      --
      -- All presets have the following mappings:
      -- C-space: Open menu or open docs if already open
      -- C-n/C-p or Up/Down: Select next/previous item
      -- C-e: Hide menu
      -- C-k: Toggle signature help (if signature.enabled = true)
      --
      -- See :h blink-cmp-config-keymap for defining your own keymap
      keymap = { preset = 'default' },

      appearance = {
        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'mono'
      },

      -- (Default) Only show the documentation popup when manually triggered
      completion = { documentation = { auto_show = false } },

      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },

      -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
      -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
      -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
      --
      -- See the fuzzy documentation for more information
      fuzzy = { implementation = "prefer_rust_with_warning" }
    },
    opts_extend = { "sources.default" }
  },
}

--[[Disable automatic previews.
require("markview").setup({
    preview = { enable = false }
});

vim.api.nvim_set_keymap("n", "<leader>m", "<CMD>Markview<CR>", { desc = "Toggles `markview` previews globally." }); --]]
