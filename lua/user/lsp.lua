-- -- generic LSP settings <https://www.lunarvim.org/docs/languages#lsp-support>

-- -- make sure server will always be installed even if the server is in skipped_servers list
lvim.lsp.installer.setup.ensure_installed = {
  "lua_ls",
  "jsonls",
}

-- LSP
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "clangd" })
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "gopls" })
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "jdtls" })
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "php" })
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright", "jsonls" })
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "rust_analyzer" })
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "tsserver" })

-- --- disable automatic installation of servers
-- lvim.lsp.installer.setup.automatic_installation = false

-- ---configure a server manually. IMPORTANT: Requires `:LvimCacheReset` to take effect
-- ---see the full default list `:lua =lvim.lsp.automatic_configuration.skipped_servers`
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pyright", opts)

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. IMPORTANT: Requires `:LvimCacheReset` to take effect
-- ---`:LvimInfo` lists which server(s) are skipped for the current filetype
-- lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
--   return server ~= "emmet_ls"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
lvim.lsp.on_attach_callback = function(client, bufnr)
  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end
  --Enable completion triggered by <c-x><c-o>
  buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
end

local lvim_lsp = require("lvim.lsp")
local ts = require("typescript")

local common_on_attach = lvim_lsp.common_on_attach
local common_capabilities = lvim_lsp.common_capabilities()

lvim.lsp.on_attach_callback = function(client, bufnr)
  if lvim.colorscheme == "gruvbox" then
    -- change coloring of errors so I can actually read them with gruvbox
    vim.cmd(":hi DiagnosticError guifg=#de5b64 guibg=#1C1C1C")
    vim.cmd(":hi DiagnosticWarn guifg=DarkOrange ctermfg=DarkYellow")
    vim.cmd(":hi DiagnosticInfo guifg=Cyan ctermfg=Cyan")
    vim.cmd(":hi DiagnosticHint guifg=White ctermfg=White")
  end
end

-- Typescript config using typescript.nvim
ts.setup({
  server = {
    root_dir = require("lspconfig.util").root_pattern(".git"),
    capabilities = common_capabilities,
    on_attach = common_on_attach,
  },
})

-- -- Keeping this here for reference
-- require("lvim.lsp.manager").setup("tsserver", {
--   root_dir = require('lspconfig.util').root_pattern('.git'),
--   on_attach = common_on_attach,
--   filetypes = { "typescript", "typescriptreact", "typescript.tsx", "javascript" },
--   cmd = {
--     "typescript-language-server",
--     "--stdio",
--   },
-- })

-- lvim.lsp.diagnostics.float.max_width = 120
-- lvim.lsp.diagnostics.float.focusable = true

-- -- linters and formatters <https://www.lunarvim.org/docs/languages#lintingformatting>
local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
  { command = "stylua",    filetypes = { "lua" } },
  { command = "goimports", filetypes = { "go" } },
  { command = "gofumpt",   filetypes = { "go" } },
  { command = "black",     filetypes = { "python" } },
  { command = "isort",     filetypes = { "python" } },
  {
    -- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
    command = "prettier",
    ---@usage arguments to pass to the formatter
    -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
    extra_args = { "--print-with", "100" },
    ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
    filetypes = { "typescript", "typescriptreact" },
  },
  {
    command = "prettierd",
    filetypes = {
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
      "vue",
      "css",
      "scss",
      "less",
      "html",
      "yaml",
      "markdown",
      "markdown.mdx",
      "graphql",
      "handlebars",
      "json",
    },
  },
  { command = "phpcsfixer", filetypes = { "php" } },
})

lvim.format_on_save.enabled = false
lvim.format_on_save.pattern = { "*.lua", "*.go", "*.php", "*.py", "*.rs" }

-- -- set additional linters
local linters = require("lvim.lsp.null-ls.linters")
linters.setup({
  { command = "flake8", args = { "--ignore=E203" }, filetypes = { "python" } },
  {
    -- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
    command = "shellcheck",
    ---@usage arguments to pass to the formatter
    -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
    extra_args = { "--severity", "warning" },
  },
  {
    command = "codespell",
    ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
    filetypes = { "javascript", "python" },
  },
  {
    command = "eslint_d",
    filetypes = { "javascript", "typescript", "typescriptreact", "json" },
  },
  { command = "phpcs", filetypes = { "php" } },
})

-- Custom Configuration
lvim.builtin.cmp.formatting.source_names["copilot"] = "(Copilot)"
table.insert(lvim.builtin.cmp.sources, 1, { name = "copilot" })

local pyright_opts = {
  single_file_support = true,
  settings = {
    pyright = {
      disableLanguageServices = false,
      disableOrganizeImports = false
    },
    python = {
      analysis = {
        autoImportCompletions = true,
        autoSearchPaths = true,
        diagnosticMode = "workspace", -- openFilesOnly, workspace
        typeCheckingMode = "basic",   -- off, basic, strict
        useLibraryCodeForTypes = true
      }
    }
  },
}

require("lvim.lsp.manager").setup("pyright", pyright_opts)

local json_opts = {
  settings = {
    json = {
      schemas = vim.list_extend(
        {
          {
            description = "pyright config",
            fileMatch = { "pyrightconfig.json" },
            name = "pyrightconfig.json",
            url =
            "https://raw.githubusercontent.com/microsoft/pyright/main/packages/vscode-pyright/schemas/pyrightconfig.schema.json",
          },
        },
        require('schemastore').json.schemas {
        }
      ),
    },
  },
}

require("lvim.lsp.manager").setup("jsonls", json_opts)
