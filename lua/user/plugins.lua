-- -- Additional Plugins <https://www.lunarvim.org/docs/plugins#user-plugins>
lvim.plugins = {
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },

	{ "olexsmir/gopher.nvim" },
	{ "leoluz/nvim-dap-go" },
	{ "mfussenegger/nvim-jdtls" },
	{ "ChristianChiarulli/swenv.nvim" },
	{ "stevearc/dressing.nvim" },
	{ "mfussenegger/nvim-dap-python" },

	{ "nvim-neotest/neotest" },
	{ "nvim-neotest/neotest-go" },
	{ "nvim-neotest/neotest-plenary" },
	{ "nvim-neotest/neotest-python" },

	{ "simrat39/rust-tools.nvim" },
	{
		"saecki/crates.nvim",
		version = "v0.3.0",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("crates").setup({
				null_ls = {
					enabled = true,
					name = "crates.nvim",
				},
				popup = {
					border = "rounded",
				},
			})
		end,
	},

	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			-- add any options here
		},
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			"rcarriga/nvim-notify",
		},
	},

	{ "lunarvim/lunar.nvim" },
	{ "morhetz/gruvbox" },
	{ "sainnhe/gruvbox-material" },
	{ "sainnhe/sonokai" },
	{ "sainnhe/edge" },
	{ "lunarvim/horizon.nvim" },
	{ "tomasr/molokai" },
	{ "ayu-theme/ayu-vim" },

	{
		"folke/trouble.nvim",
		cmd = "TroubleToggle",
		-- opts will be merged with the parent spec
		opts = { use_diagnostic_signs = true },
	},

	{
		"folke/todo-comments.nvim",
		event = "BufRead",
		config = function()
			require("todo-comments").setup()
		end,
	},

	{
		"folke/persistence.nvim",
		event = "BufReadPre",
		config = function()
			require("persistence").setup({
				dir = vim.fn.expand(vim.fn.stdpath("state") .. "/sessions/"), -- directory where session files are saved
				options = { "buffers", "curdir", "tabpages", "winsize" }, -- sessionoptions used for saving
				pre_save = nil, -- a function to call before saving the session
			})
		end,
	},

	{ "christoomey/vim-tmux-navigator" },
	{ "felipec/vim-sanegx", event = "BufRead" },
	{
		"windwp/nvim-ts-autotag",
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	},

	{ "tpope/vim-surround" },
	{ "tpope/vim-repeat" },

	{ "ThePrimeagen/harpoon" },

	{
		"j-hui/fidget.nvim",
		config = function()
			require("fidget").setup({})
		end,
	},
	{
		"jackMort/ChatGPT.nvim",
		config = function()
			require("chatgpt").setup({
				--optional configuration
				-- keymaps = {
				--   submit = "<C-a>",
				-- }
				api_key_cmd = "pass show api/tokens/openai",
			})
		end,
		dependencies = {
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
	},

	{ "lervag/vimtex" },
	{ "kdheepak/cmp-latex-symbols" },
	{ "KeitaNakamura/tex-conceal.vim" },
	{ "SirVer/ultisnips" },
	{ "rafi/awesome-vim-colorschemes" },

	{
		"phaazon/hop.nvim",
		branch = "v2",
		config = function()
			require("hop").setup()
		end,
	},

	{
		"nvim-telescope/telescope-frecency.nvim",
		dependencies = { "nvim-telescope/telescope.nvim", "kkharji/sqlite.lua" },
	},

	{
		"AckslD/nvim-trevJ.lua",
		config = 'require("trevj").setup()',
		init = function()
			vim.keymap.set("n", "<leader>j", function()
				require("trevj").format_at_cursor()
			end)
		end,
	},

	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				suggestions = { enabled = false },
				panel = { enabled = false },
			})
		end,
	},

	{
		"zbirenbaum/copilot-cmp",
		event = "InsertEnter",
		dependencies = { "zbirenbaum/copilot.lua" },
		config = function()
			local ok, cmp = pcall(require, "copilot_cmp")
			if ok then
				cmp.setup({})
			end
		end,
	},

	{ "jose-elias-alvarez/typescript.nvim" },

	{
		"folke/flash.nvim",
		event = "VeryLazy",
		-- @type Flash.Config
		opts = {},
    -- stylua: ignore
    keys = {
      { "s",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump(
            {
              matcher = function(win)
                -- @param diag Diagnostic
                return vim.tbl_map(function(diag)
                  return {
                  pos = { diag.lnum + 1, diag.col },
                  end_pos = { diag.end_lnum + 1, diag.end_col - 1 },
                  }
                end, vim.diagnostic.get(vim.api.nvim_win_get_buf(win)))
              end,
              action = function(match, state)
                vim.api.nvim_win_call(match.win, function()
                  vim.api.nvim_win_set_cursor(match.win, match.pos)
                  vim.diagnostic.open_float()
                end)
                state:restore()
              end,
            },
            {
              search = {
                mode = function(str)
                  return "\\<" .. str
                end,
              },
            }
          )
        end,
        desc = "Flash"
      },
      { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
	},
}

lvim.builtin.telescope.on_config_done = function(telescope)
	pcall(telescope.load_extension, "frecency")
end
