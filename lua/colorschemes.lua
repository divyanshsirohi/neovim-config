
local utils = require("utils")

local M = {}

local use_theme = vim.cmd.colorscheme

M.colorscheme_conf = {
  onedark = function()
    require("onedark").setup { style = "darker" }
    require("onedark").load()
  end,
  edge = function()
    vim.g.edge_style = "default"
    vim.g.edge_enable_italic = 1
    vim.g.edge_better_performance = 1
    use_theme("edge")
  end,
  sonokai = function()
    vim.g.sonokai_enable_italic = 1
    vim.g.sonokai_better_performance = 1
    use_theme("sonokai")
  end,
  gruvbox_material = function()
    vim.g.gruvbox_material_foreground = "original"
    vim.g.gruvbox_material_background = "hard"
    vim.g.gruvbox_material_enable_italic = 1
    vim.g.gruvbox_material_better_performance = 1
    use_theme("gruvbox-material")
  end,
  everforest = function()
    vim.g.everforest_background = "hard"
    vim.g.everforest_enable_italic = 1
    vim.g.everforest_better_performance = 1
    use_theme("everforest")
  end,
  nightfox = function()
    use_theme("carbonfox")
  end,
  onedarkpro = function()
    use_theme("onedark_dark")
  end,
  material = function()
    vim.g.material_style = "darker"
    use_theme("material")
  end,
  arctic = function()
    use_theme("arctic")
  end,
  kanagawa = function()
    use_theme("kanagawa-dragon")
  end,
  modus = function()
    use_theme("modus")
  end,
  jellybeans = function()
    use_theme("jellybeans")
  end,
  github = function()
    use_theme("github_dark_default")
  end,
  e_ink = function()
    require("e-ink").setup()
    use_theme("e-ink")
  end,
  ashen = function()
    use_theme("ashen")
  end,
  melange = function()
    use_theme("melange")
  end,
  makurai = function()
    use_theme("makurai_dark")
  end,
  vague = function()
    use_theme("vague")
  end,
  kanso = function()
    use_theme("kanso")
  end,
  citruszest = function()
    use_theme("citruszest")
  end,
  quiet = function()
    use_theme("quiet")
  end,
}

-- ============================
-- NO RANDOM THEME ANYMORE
-- This function is called by your selector
-- and will simply apply the theme requested.
-- ============================

M.rand_colorscheme = function(name)
  if name and M.colorscheme_conf[name] then
    -- Use your custom configured themes
    M.colorscheme_conf[name]()
  elseif name then
    -- Fallback for Treesitter/UI-selected themes
    vim.cmd.colorscheme(name)
  else
    -- Final safety fallback
    M.colorscheme_conf.kanagawa()
  end
end

return M
