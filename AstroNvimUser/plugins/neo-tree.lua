return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    filesystem = {
      filtered_items = {
        visible = true,        -- 隠しファイルを表示するが、他のアイテムとは異なる表示にする
        hide_dotfiles = false, -- ドットファイルを表示
      },
    },
  },
}
