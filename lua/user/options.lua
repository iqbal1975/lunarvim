-- Vim Options
-- Global
vim.g.mapleader = " " -- sets vim.g.mapleader
vim.g.autoformat_enabled = true -- enable or disable auto formatting at start (lsp.formatting.format_on_save must be enabled)
vim.g.cmp_enabled = true -- enable completion at start
vim.g.autopairs_enabled = true -- enable autopairs at start
vim.g.diagnostics_mode = 3 -- set the visibility of diagnostics in the UI (0=off, 1=only show in status line, 2=virtual text off, 3=all on)
vim.g.icons_enabled = true -- disable icons in the UI (disable if no nerd font is available, requires :PackerSync after changing)
vim.g.ui_notifications_enabled = true -- disable notifications when toggling UI elements

-- Optional
vim.opt.colorcolumn = "90"
vim.opt.completeopt = { "menuone", "noinsert", "noselect" }
vim.opt.linebreak = true
vim.opt.listchars = {
	-- list of hidden characters
	tab = "» ",
	trail = "•",
	precedes = "←",
	extends = "→",
	eol = "↲",
	space = "␣",
}
vim.opt.nrformats = { "alpha", "octal", "hex" }
vim.opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
vim.opt.shell = "/bin/zsh"
vim.opt.showbreak = "↪"
vim.opt.shiftwidth = 2
vim.opt.splitbelow = true
vim.opt.splitright = true
-- vim.opt.number = true -- sets vim.opt.number
-- vim.opt.relativenumber = true -- sets vim.opt.relativenumber
vim.opt.signcolumn = "auto" -- sets vim.opt.signcolumn to auto
vim.opt.spell = false -- sets vim.opt.spell
-- vim.opt.statuscolumn = "%l %r"
vim.opt.tabstop = 2
-- vim.opt.winbar = "%=%m %f"
vim.opt.wrap = false -- sets vim.opt.wrap

vim.cmd([[filetype plugin indent on]])
vim.diagnostic.config({ virtual_text = true })

-- General
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
