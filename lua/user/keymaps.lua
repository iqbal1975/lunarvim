-- keymappings <https://www.lunarvim.org/docs/configuration/keybindings>
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"

lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"

-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
local _, actions = pcall(require, "telescope.actions")
lvim.builtin.telescope.defaults.mappings = {
	-- for input mode
	i = {
		["<C-j>"] = actions.move_selection_next,
		["<C-k>"] = actions.move_selection_previous,
		["<C-n>"] = actions.cycle_history_next,
		["<C-p>"] = actions.cycle_history_prev,
	},
	-- for normal mode
	n = {
		["<C-j>"] = actions.move_selection_next,
		["<C-k>"] = actions.move_selection_previous,
	},
}

-- -- Use which-key to add extra bindings with the leader-key prefix
lvim.builtin.which_key.mappings["W"] = { "<cmd>noautocmd w<cr>", "Save without formatting" }
lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
lvim.builtin.which_key.mappings["t"] = {
	name = "+Trouble",
	r = { "<cmd>Trouble lsp_references<cr>", "References" },
	f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
	d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
	q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
	l = { "<cmd>Trouble loclist<cr>", "LocationList" },
	w = { "<cmd>Trouble workspace_diagnostics<cr>", "Workspace Diagnostics" },
}

vim.keymap.set("n", "gn", ":tabe %<CR>")

local kind = require("user.kind")
lvim.lsp.buffer_mappings.normal_mode["gr"] = {
	":lua require'telescope.builtin'.lsp_references()<cr>",
	kind.cmp_kind.Reference .. " Find references",
}

lvim.lsp.buffer_mappings.normal_mode["gd"] = {
	":lua vim.lsp.buf.definition()<cr>",
	-- ":lua require'telescope.builtin'.lsp_definitions()<cr>",
	kind.cmp_kind.Reference .. " Definitions",
}

lvim.lsp.buffer_mappings.normal_mode["gD"] = {
	":lua vim.lsp.buf.type_definition()<cr>",
	kind.cmp_kind.Reference .. " Type Definition",
}

lvim.lsp.buffer_mappings.normal_mode["gf"] = {
	":Telescope frecency<cr>",
	kind.cmp_kind.Reference .. " Telescope Frecency",
}
