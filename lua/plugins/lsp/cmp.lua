local cmp = require 'cmp'
local luasnip = require 'luasnip'

local cmp_kinds = {
  Text = ' ',
  Method = ' ',
  Function = ' ',
  Constructor = ' ',
  Field = ' ',
  Variable = ' ',
  Class = ' ',
  Interface = ' ',
  Module = ' ',
  Property = ' ',
  Unit = ' ',
  Value = ' ',
  Enum = ' ',
  Keyword = ' ',
  Snippet = ' ',
  Color = ' ',
  File = ' ',
  Reference = ' ',
  Folder = ' ',
  EnumMember = ' ',
  Constant = ' ',
  Struct = ' ',
  Event = ' ',
  Operator = ' ',
  TypeParameter = ' '
}

local keymap_opts = {
  'i',
  'c',
  's'
}

cmp.setup {
  window = {
    completion = {
      border = 'single',
      winhighlight = 'FloatBorder:FloatBorder,CursorLine:CmpSelection',
    },
    documentation = {
      border = 'single',
      winhighlight = 'FloatBorder:FloatBorder'
    }
  },
  completion = {
    completeopt = 'menuone'
  },
  formatting = {
    format = function(_, vim_item)
      vim_item.kind = (cmp_kinds[vim_item.kind] or '') .. ' ' .. vim_item.kind
      return vim_item
    end
  },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end
  },
  sources = cmp.config.sources {
    { name = 'nvim_lsp' },
    { name = 'path' },
    { name = 'luasnip' },
    { name = 'buffer' }
  },
  mapping = cmp.mapping.preset.insert {
    ['<c-space>'] = cmp.mapping(function()
      if cmp.visible() then
        cmp.close()
      else
        cmp.complete()
      end
    end, keymap_opts),
    ['<tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item { behavior = cmp.SelectBehavior.Select }
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, keymap_opts),
    ['<s-tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item { behavior = cmp.SelectBehavior.Select }
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, keymap_opts),
    ['<cr>'] = cmp.mapping(function(fallback)
      if cmp.visible() and cmp.get_selected_entry() then
        cmp.confirm()
      else
        fallback()
      end
    end, keymap_opts),
    ['<c-j>'] = cmp.mapping(cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Select }, keymap_opts),
    ['<c-k>'] = cmp.mapping(cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Select }, keymap_opts),
    ['<c-u>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), keymap_opts),
    ['<c-d>'] = cmp.mapping(cmp.mapping.scroll_docs(4), keymap_opts)
  }
}

cmp.setup.cmdline(':', {
  sources = {
    { name = 'cmdline' }
  }
})

cmp.setup.cmdline('/', {
  sources = {
    { name = 'buffer' }
  }
})

cmp.setup.cmdline('?', {
  sources = {
    { name = 'buffer' }
  }
})
