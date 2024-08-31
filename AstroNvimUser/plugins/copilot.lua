-- ~/.config/nvim/lua/user/copilot.lua
return {
	"github/copilot.vim",
	config = function()
		vim.g.copilot_no_tab_map = true -- Tabキーの補完を無効化
		vim.api.nvim_set_keymap("i", "<C-g>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
	end,
}
