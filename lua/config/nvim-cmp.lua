local cmp = require("cmp")
local luasnip = require("luasnip")

-- Load VSCode-style snippets from friendly-snippets
require("luasnip.loaders.from_vscode").lazy_load()

-- The extensions needed by nvim-cmp should be loaded beforehand
require("cmp_nvim_lsp")
require("cmp_path")
require("cmp_buffer")
require("cmp_omni")
require("cmp_cmdline")

local MiniIcons = require("mini.icons")

cmp.setup {
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body) -- ✅ LuaSnip (NOT UltiSnips)
    end,
  },

  mapping = cmp.mapping.preset.insert {
    ["<Tab>"] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end,

    ["<S-Tab>"] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end,

    ["<CR>"] = cmp.mapping.confirm { select = true },
    ["<C-e>"] = cmp.mapping.abort(),
    ["<Esc>"] = cmp.mapping.close(),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
  },

  sources = {
    { name = "nvim_lsp" }, -- ✅ LSP completion
    { name = "luasnip" },  -- ✅ LuaSnip (replaces UltiSnips)
    { name = "path" },
    { name = "buffer", keyword_length = 2 },
  },

  completion = {
    keyword_length = 1,
    completeopt = "menu,noselect",
  },

  view = {
    entries = "custom",
  },

  formatting = {
    format = function(_, vim_item)
      local icon, hl = MiniIcons.get("lsp", vim_item.kind)
      vim_item.kind = icon .. " " .. vim_item.kind
      vim_item.kind_hl_group = hl
      return vim_item
    end,
  },
}

-- ✅ TeX setup (LuaSnip version)
cmp.setup.filetype("tex", {
  sources = {
    { name = "omni" },
    { name = "luasnip" }, -- ✅ NOT ultisnips
    { name = "buffer", keyword_length = 2 },
    { name = "path" },
  },
})

cmp.setup.cmdline("/", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "buffer" },
  },
})

cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "path" },
  }, {
    { name = "cmdline" },
  }),
  matching = { disallow_symbol_nonprefix_matching = false },
})

vim.cmd([[
  highlight! link CmpItemMenu Comment
  highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080
  highlight! CmpItemAbbrMatch guibg=NONE guifg=#569CD6
  highlight! CmpItemAbbrMatchFuzzy guibg=NONE guifg=#569CD6
  highlight! CmpItemKindVariable guibg=NONE guifg=#9CDCFE
  highlight! CmpItemKindInterface guibg=NONE guifg=#9CDCFE
  highlight! CmpItemKindText guibg=NONE guifg=#9CDCFE
  highlight! CmpItemKindFunction guibg=NONE guifg=#C586C0
  highlight! CmpItemKindMethod guibg=NONE guifg=#C586C0
  highlight! CmpItemKindKeyword guibg=NONE guifg=#D4D4D4
  highlight! CmpItemKindProperty guibg=NONE guifg=#D4D4D4
  highlight! CmpItemKindUnit guibg=NONE guifg=#D4D4D4
]])
