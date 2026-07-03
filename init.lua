local ALL_MODES = { "n", "v", "i", "c", "o" }
local N_I = { "n", "i" }
local LANGS = {
	"bash",
	"diff",
	"html",
	"lua",
	"luadoc",
	"markdown",
	"markdown_inline",
	"query",
	"xml",
	"clojure",
	"java",
	"json",
	"css",
	"javascript",
	"yaml",
}
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.schedule(function()
	vim.o.clipboard = "unnamedplus"
end)

vim.o.undofile = true
vim.keymap.set(ALL_MODES, "<C-s>", "<CMD>wa<CR>")
vim.keymap.set(N_I, "<C-z>", "<CMD>u<CR>")
vim.keymap.set(N_I, "<C-r>", "<CMD>redo<CR>")

vim.keymap.set("n", "<leader>q", "<CMD>quit<CR>")

vim.o.number = true
vim.opt.relativenumber = true
vim.o.mouse = "a"
vim.o.showmode = false
vim.o.breakindent = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.signcolumn = "yes"
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.o.inccommand = "split"
vim.o.cursorline = true
vim.o.scrolloff = 10
vim.o.confirm = true
vim.opt.hlsearch = false

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

vim.pack.add({ "https://github.com/Mofiqul/vscode.nvim" })
vim.pack.add({ "https://github.com/projekt0n/github-nvim-theme" })
vim.pack.add({ "https://github.com/rktjmp/lush.nvim" })
vim.pack.add({ "https://github.com/ntk148v/habamax.nvim" })

--vim.cmd.colorscheme("vscode")
--vim.cmd.colorscheme("github_dark_default")
vim.cmd.colorscheme("habamax.nvim")

vim.pack.add({ "https://github.com/lewis6991/gitsigns.nvim" })
require("gitsigns").setup({
	signs = {
		add = { text = "+" },
		change = { text = "~" },
		delete = { text = "_" },
		topdelete = { text = "‾" },
		changedelete = { text = "~" },
		untracked = { text = "u" },
	},
	attach_to_untracked = true,
})

vim.pack.add({ "https://github.com/nvim-tree/nvim-web-devicons" })
vim.pack.add({ "https://github.com/nvim-lualine/lualine.nvim" })
require("lualine").setup({
	icons_enabled = true,
	theme = "vscode",
	sections = {
		lualine_c = {
			{
				"filename",
				file_status = true,
				path = 1,
				symbols = {
					modified = "[*]",
					readonly = "[ro]",
					unnamed = "[No Name]",
					newfile = "[New]",
				},
				color = {
					fg = "black",
					gui = "bold",
				},
			},
		},
		lualine_x = { "encoding", "filetype" },
		lualine_y = {},
		lualine_z = {},
	},
})

vim.pack.add({ "https://github.com/j-hui/fidget.nvim" })
require("fidget").setup({
	notification = {
		override_vim_notify = true, -- Automatically override vim.notify() with Fidget
	},
})
vim.pack.add({ "https://github.com/neovim/nvim-lspconfig" })
vim.pack.add({ "https://github.com/mason-org/mason.nvim.git" })
vim.pack.add({ "https://github.com/mason-org/mason-lspconfig.nvim" })
require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = { "clojure_lsp", "stylua", "texlab" },
})
vim.lsp.enable("clojure_lsp")
vim.filetype.add({
	extension = {
		bb = "clojure",
	},
})

vim.pack.add({ "https://github.com/folke/lazydev.nvim" })
require("lazydev").setup({
	ft = "lua", -- only load on lua files
	opts = {
		library = {
			-- See the configuration section for more details
			-- Load luvit types when the `vim.uv` word is found
			{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
		},
	},
})

vim.pack.add({ "https://github.com/stevearc/conform.nvim" })
require("conform").setup({
	format_on_save = {
		timeout_ms = 1000,
		lsp_format = "never",
	},
	formatters_by_ft = {
		lua = { "stylua" },
		json = { "jq" },
		html = { "prettier" },
		javascript = { "prettier" },
		clojure = { "cljfmt" },
		xml = { "xmlformatter" },
		tex = { "tex-fmt" },
	},
})

vim.pack.add({
	{
		src = "https://github.com/nvim-treesitter/nvim-treesitter",
		version = "main",
	},
})

require("nvim-treesitter").install(LANGS)

vim.g.matchparen_disable_cursor_hl = 1
vim.pack.add({ "https://github.com/HiPhish/rainbow-delimiters.nvim" })

vim.pack.add({ "https://github.com/ibhagwan/fzf-lua" })
require("fzf-lua").register_ui_select()
local actions = require("fzf-lua.actions")
require("fzf-lua").setup({
	defaults = {
		formatter = "path.filename_first",
	},
	keymap = {
		fzf = {
			["ctrl-q"] = "select-all+accept",
		},
	},
	buffers = {
		file_icons = false,
		winopts = {
			preview = {
				hidden = "hidden",
			},
			height = 0.5,
			width = 0.5,
		},
		actions = {
			["ctrl-x"] = { fn = actions.buf_del, reload = true },
		},
	},
	git = {
		files = {
			winopts = {
				preview = {
					hidden = "hidden",
				},
			},
			actions = false,
		},
	},
})
vim.keymap.set("n", "<F1>", "<CMD>FzfLua buffers<CR>")
vim.keymap.set("n", "<F5>", "<CMD>FzfLua git_files<CR>")
vim.keymap.set("n", "<F3>", "<CMD>FzfLua grep_cword<CR>")
vim.keymap.set("n", "<F2>", "<CMD>FzfLua lsp_references<CR>")
vim.keymap.set("n", "<F4>", "<CMD>FzfLua lsp_code_actions<CR>")
vim.keymap.set("n", "<F6>", "<CMD>lua vim.lsp.buf.rename()<CR>")
vim.keymap.set("n", "<F7>", "<CMD>FzfLua lsp_document_symbols<CR>")

vim.keymap.set("n", "<M-Up>", "<CMD>cprev<CR>")
vim.keymap.set("n", "<M-Down>", "<CMD>cnext<CR>")
vim.keymap.set("n", "<M-q>", "<CMD>cclose<CR>")

vim.pack.add({
	{
		src = "https://github.com/saghen/blink.cmp",
		version = vim.version.range("^1"),
	},
})
require("blink.cmp").setup({
	keymap = {
		preset = "enter",
	},
	appearance = {
		nerd_font_variant = "mono",
	},
	completion = {
		documentation = { auto_show = false, auto_show_delay_ms = 500 },
	},
	signature = { enabled = true },
	fuzzy = { implementation = "rust" },
	sources = {
		default = { "lsp", "path", "snippets", "buffer" },
	},
})

vim.pack.add({ "https://github.com/nvim-mini/mini.pairs" })
require("mini.pairs").setup({})

vim.pack.add({ "https://github.com/julienvincent/nvim-paredit" })
local paredit = require("nvim-paredit")
paredit.setup({
	keys = {
		["<C-Right>"] = {
			paredit.api.slurp_forwards,
			"Slurp forwards",
			mode = { "n", "i" },
			repeatable = false,
		},
		["<C-Left>"] = {
			paredit.api.barf_forwards,
			"Barf forwards",
			mode = { "n", "i" },
			repeatable = false,
		},
	},
})

vim.api.nvim_set_keymap("n", "<Tab>", "%", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<Tab>", "<C-O>%", { noremap = true, silent = true })
vim.keymap.set("n", "t", "<CMD>lua vim.lsp.buf.definition()<CR>")

vim.api.nvim_set_keymap("i", "<C-d>", "<C-O>d%", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-d>", "d%", { noremap = true, silent = true })

vim.api.nvim_set_keymap("i", "<C-Del>", "<C-O>daw", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-Del>", "daw", { noremap = true, silent = false })

-- Normal mode: Enter visual mode and select the current node (outward)
vim.keymap.set("n", "+", "van", { remap = true, desc = "Start incremental selection" })
-- Visual mode: Continue expanding or shrinking
vim.keymap.set("x", "+", "an", { remap = true, desc = "Increment selection" })

vim.g["conjure#mapping#enable_defaults"] = false
vim.g["conjure#mapping#log_tab"] = { "<F9>" }
vim.g["conjure#mapping#eval_buf"] = { "<F10>" }
vim.g["conjure#mapping#eval_word"] = { "<F11>" }
vim.g["conjure#mapping#log_reset_soft"] = { "<F12>" }
vim.g["conjure#mapping#eval_current_form"] = { "<C-Up>" }
vim.keymap.set(N_I, "<C-Down>", "gt")
vim.pack.add({ "https://github.com/Olical/conjure" })
vim.keymap.set("i", "<C-Up>", "<CMD>ConjureEvalCurrentForm<CR>")

vim.api.nvim_create_autocmd({ "BufEnter" }, {
	desc = "Force readonly for jars and decompiled java files",
	pattern = "*",
	group = vim.api.nvim_create_augroup("force-readonly", { clear = true }),
	callback = function(args)
		if (string.find(args.match, "%.jar")) or (string.find(args.match, "clojure%-lsp")) then
			vim.api.nvim_buf_set_option(args.buf, "modifiable", false)
		end
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "*",
	callback = function()
		local filetype = vim.bo.filetype
		if filetype and filetype ~= "" then
			pcall(vim.treesitter.start)
		end
	end,
})

vim.g.vimtex_view_method = "zathura"
vim.g.vimtex_matchparen_enabled = 0
vim.pack.add({ "https://github.com/lervag/vimtex" })

vim.diagnostic.config({
	severity_sort = true,
	float = { border = "rounded", source = "if_many" },
	underline = { severity = vim.diagnostic.severity.ERROR },
	signs = true and {
		text = {
			[vim.diagnostic.severity.ERROR] = "󰅚 ",
			[vim.diagnostic.severity.WARN] = "󰀪 ",
			[vim.diagnostic.severity.INFO] = "󰋽 ",
			[vim.diagnostic.severity.HINT] = "󰌶 ",
		},
	} or {},
	virtual_text = {
		source = "if_many",
		spacing = 2,
		format = function(diagnostic)
			local diagnostic_message = {
				[vim.diagnostic.severity.ERROR] = diagnostic.message,
				[vim.diagnostic.severity.WARN] = diagnostic.message,
				[vim.diagnostic.severity.INFO] = diagnostic.message,
				[vim.diagnostic.severity.HINT] = diagnostic.message,
			}
			return diagnostic_message[diagnostic.severity]
		end,
	},
})

vim.api.nvim_set_hl(0, "@lsp.type.keyword.clojure", { fg = 11513735 })
vim.api.nvim_create_autocmd("FileType", {
	pattern = "tex",
	callback = function()
		vim.api.nvim_set_hl(0, "Statement", { fg = 14124895 })
		vim.api.nvim_set_hl(0, "Special", { fg = 8892335 })
	end,
})

vim.pack.add({ "https://www.github.com/nvim-lua/plenary.nvim" })
vim.pack.add({ "https://github.com/nvim-treesitter/nvim-treesitter" })
vim.pack.add({
	{
		src = "https://www.github.com/olimorris/codecompanion.nvim",
		version = vim.version.range("^19.0.0"),
	},
})

require("codecompanion").setup()
