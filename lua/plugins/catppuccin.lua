
	-- Catppuccin color scheme plugin with high priority for loading first
return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	config = function()
	vim.cmd.colorscheme "catppuccin"
	end
	}
