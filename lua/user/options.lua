-- vim options
local options = {
	colorcolumn = "80",
	completeopt = { "menuone", "noinsert", "noselect" },
	linebreak = true,
  listchars = {
		-- list of hidden characters
		tab = "» ",
		trail = "•",
		precedes = "←",
		extends = "→",
		eol = "↲",
		space = "␣",
	},
	nrformats = { "alpha", "octal", "hex" },
  sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions",
	shell = "/bin/zsh",
  showbreak = "↪",
	splitbelow = true,
	splitright = true,
	shiftwidth = 2,
	tabstop = 2,
	relativenumber = true,
  wrap = false,
	-- winbar = "%=%m %f"
}

for k, v in pairs(options) do
	vim.opt[k] = v
end

vim.cmd([[filetype plugin indent on]])
vim.diagnostic.config({ virtual_text = true })

-- general
-- lvim.log.level = "info"
lvim.log.level = "warn"
lvim.format_on_save = {
	enabled = true,
	pattern = "*.lua",
	timeout = 1000,
}
-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false

if vim.g.neovide then
	vim.opt.guifont = "MonoLisa:h24"

	vim.g.neovide_transparency = 1
	vim.g.transparency = 0.8
	vim.g.neovide_scroll_animation_length = 0.3
	vim.g.neovide_refresh_rate = 60
	vim.g.neovide_confirm_quit = true
	vim.g.neovide_input_macos_alt_is_meta = false
end

-- -- always installed on startup, useful for parsers without a strict filetype
lvim.builtin.treesitter.ensure_installed = {
	"bash",
	"c",
	"cpp",
	"css",
  "go",
  "gomod",
	"java",
	"javascript",
	"json",
  "latex",
	"lua",
	"markdown_inline",
	"python",
	"regex",
	"rust",
  "toml",
	"tsx",
	"typescript",
	"yaml",
}

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = true
lvim.builtin.nvimtree.setup.filters.custom = {}

-- Automatically install missing parsers when entering buffer
lvim.builtin.treesitter.auto_install = true

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enable = true

lvim.builtin.project.detection_methods = { "lsp", "pattern" }
lvim.builtin.project.patterns = {
	".git",
	"package-lock.json",
	"yarn.lock",
	"package.json",
	"requirements.txt",
}

lvim.builtin.telescope.defaults.path_display = {
	shorten = 4,
}
