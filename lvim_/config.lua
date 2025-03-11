-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Example configs: https://github.com/LunarVim/starter.lvim
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

reload "user.plugins"
reload "user.options"
reload "user.keymaps"
reload "user.lsp"
reload "user.smoothie"
reload "user.harpoon"
reload "user.autocommands"
reload "user.webdev-icons"
reload "user.cybu"
reload "user.neotest"
reload "user.surround"
reload "user.bookmark"
reload "user.todo-comments"
reload "user.jaq"
reload "user.fidget"
reload "user.lab"
reload "user.git"
reload "user.zen-mode"
reload "user.inlay-hints"
reload "user.telescope"
reload "user.bqf"
reload "user.dial"
reload "user.numb"
reload "user.treesitter"
reload "user.neogit"
reload "user.colorizer"
reload "user.lualine"
reload "user.tabnine"
reload "user.copilot"
-- reload "user.chatgpt"
reload "user.whichkey"
reload "user.neoai"
reload "user.cmp"
reload "user.nvimtree"
reload "nostr"
reload "user.astro-tools"
reload "user.matchup"
reload "user.modicator"
vim.opt.cmdheight = 2 -- more space in the neovim command line for displaying messages
vim.opt.guifont = "monospace:h17" -- the font used in graphical neovim applications
vim.opt.shiftwidth = 4 -- the number of spaces inserted for each indentation
vim.opt.tabstop = 4 -- insert 2 spaces for a tab
vim.opt.relativenumber = true -- relative line numbers
vim.opt.clipboard = "unnamedplus" -- let lvim utilize system clipboard
-- vim.opt.wrap = false -- wrap lines

-- -- use treesitter folding
-- vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

lvim.leader = "space"

lvim.colorscheme = "lunaperche"
lvim.autocommands = {
  {
    { "ColorScheme" },
    {
      pattern = "*",
      callback = function()
        -- change `Normal` to the group you want to change
        -- and `#ffffff` to the color you want
        -- see `:h nvim_set_hl` for more options
        vim.api.nvim_set_hl(0, "Normal", { bg = "#B0C4DE", underline = false, bold = true })
      end,
    },
  },
}

lvim.transparent_window = true
lvim.builtin.lualine.style = "default" -- or "none"
lvim.builtin.lualine.style = "default"
lvim.builtin.lualine.sections.lualine_c = { "diff" }
-- no need to set style = "lvim"
local components = require("lvim.core.lualine.components")

lvim.builtin.lualine.sections.lualine_a = { "mode" }
lvim.builtin.lualine.sections.lualine_y = {
  components.spaces,
  components.location
}
lvim.builtin.lualine.options.theme = "gruvbox"
lvim.builtin.alpha.active = true
lvim.builtin.dap.active = true
lvim.builtin.cmp.completion.keyword_length = 2
lvim.builtin.telescope.defaults.layout_config.width = 0.95
lvim.builtin.telescope.defaults.layout_config.preview_cutoff = 75
lvim.plugins = {
  { "lunarvim/colorschemes" },
  {
      "nvim-neorg/neorg",
      ft = "norg", -- lazy-load on filetype
      config = true, -- run require("neorg").setup()
  },
  {
    "wakatime/vim-wakatime",
  },
  {
    "iamcco/markdown-preview.nvim",
    build = function() vim.fn["mkdp#util#install"]() end,
    ft = { "markdown" },
  }
}
local colors = {
  color2 = "#0f1419",
  color3 = "#B0C4DE",
  color4 = "#e6e1cf",
  color5 = "#14191f",
  color13 = "#b8cc52",
  color10 = "#36a3d9",
  color8 = "#f07178",
  color9 = "#3e4b59",
}

lvim.builtin.lualine.options.theme = {
  normal = {
    c = { fg = colors.color9, bg = colors.color2 },
    a = { fg = colors.color2, bg = colors.color10, gui = "bold" },
    b = { fg = colors.color4, bg = colors.color5 },
  },
  insert = {
    a = { fg = colors.color2, bg = colors.color13, gui = "bold" },
    b = { fg = colors.color4, bg = colors.color5 },
  },
  visual = {
    a = { fg = colors.color2, bg = colors.color3, gui = "bold" },
    b = { fg = colors.color4, bg = colors.color5 },
  },
  replace = {
    a = { fg = colors.color2, bg = colors.color8, gui = "bold" },
    b = { fg = colors.color4, bg = colors.color5 },
  },
  inactive = {
    c = { fg = colors.color4, bg = colors.color2 },
    a = { fg = colors.color4, bg = colors.color5, gui = "bold" },
    b = { fg = colors.color4, bg = colors.color5 },
  },
}

