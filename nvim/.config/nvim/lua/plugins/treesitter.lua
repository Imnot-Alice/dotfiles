return {
  "nvim-treesitter/nvim-treesitter",
  branch = 'master',
  lazy = false,
  build = ":TSUpdate", 
  opts = {
    ensure_installed = { "c", "lua", "cpp", "python", "toml", "html", "css", "yaml", "json", "fish", "javascript", "typescript", "dockerfile" },
	sync_install = false,
	auto_install = true,
	highlight = {
      enable = true,
	  additinoal_vim_regex_highlighting = false,
	},
  },
 
  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)
  end,
}


