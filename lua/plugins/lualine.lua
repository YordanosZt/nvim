return {
	'nvim-lualine/lualine.nvim',
	config = function()
		-- Gruvbox palette (dark variant)
		local colors = {
			blue   = '#458588',
			green  = '#98971a',
			purple = '#b16286',
			cyan   = '#689d6a',
			red1   = '#cc241d',
			red2   = '#fb4934',
			yellow = '#d79921',
			fg     = '#ebdbb2',
			bg     = '#282828',
			gray1  = '#a89984',
			gray2  = '#3c3836',
			gray3  = '#504945',
		}

		local gruvbox_theme = {
			normal = {
				a = { fg = colors.bg, bg = colors.green, gui = 'bold' },
				b = { fg = colors.fg, bg = colors.gray3 },
				c = { fg = colors.fg, bg = colors.gray2 },
			},
			command = { a = { fg = colors.bg, bg = colors.yellow, gui = 'bold' } },
			insert  = { a = { fg = colors.bg, bg = colors.blue, gui = 'bold' } },
			visual  = { a = { fg = colors.bg, bg = colors.purple, gui = 'bold' } },
			terminal= { a = { fg = colors.bg, bg = colors.cyan, gui = 'bold' } },
			replace = { a = { fg = colors.bg, bg = colors.red1, gui = 'bold' } },
			inactive = {
				a = { fg = colors.gray1, bg = colors.bg, gui = 'bold' },
				b = { fg = colors.gray1, bg = colors.bg },
				c = { fg = colors.gray1, bg = colors.gray2 },
			},
		}

		-- Import color theme based on environment variable NVIM_THEME
		local env_var_nvim_theme = os.getenv 'NVIM_THEME' or 'gruvbox'

		-- Define a table of themes
		local themes = {
			gruvbox = gruvbox_theme,
			onedark = 'onedark',
			nord    = 'nord',
		}

		local mode = {
			'mode',
			fmt = function(str)
				return ' ' .. str
			end,
		}

		local filename = {
			'filename',
			file_status = true,
			path = 0,
		}

		local hide_in_width = function()
			return vim.fn.winwidth(0) > 100
		end

		local diagnostics = {
			'diagnostics',
			sources = { 'nvim_diagnostic' },
			sections = { 'error', 'warn' },
			symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
			colored = false,
			update_in_insert = false,
			always_visible = false,
			cond = hide_in_width,
		}

		local diff = {
			'diff',
			colored = false,
			symbols = { added = ' ', modified = ' ', removed = ' ' },
			cond = hide_in_width,
		}

		require('lualine').setup {
			options = {
				icons_enabled = true,
				theme = themes[env_var_nvim_theme],
				section_separators = { left = '', right = '' },
				component_separators = { left = '', right = '' },
				disabled_filetypes = { 'alpha', 'neo-tree', 'Avante' },
				always_divide_middle = true,
			},
			sections = {
				lualine_a = { mode },
				lualine_b = { 'branch' },
				lualine_c = { filename },
				lualine_x = { diagnostics, diff, { 'encoding', cond = hide_in_width }, { 'filetype', cond = hide_in_width } },
				lualine_y = { 'location' },
				lualine_z = { 'progress' },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { { 'filename', path = 1 } },
				lualine_x = { { 'location', padding = 0 } },
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {},
			extensions = { 'fugitive' },
		}
	end,
}

