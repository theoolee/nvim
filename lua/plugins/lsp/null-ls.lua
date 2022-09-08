local null_ls = require 'null-ls'

null_ls.setup {
  sources = {
    null_ls.builtins.formatting.shfmt,
    null_ls.builtins.formatting.prettier.with {
      extra_args = {
        '--no-semi',
        '--single-quote',
        '--single-quote-jsx',
        '--single-attribute-per-line'
      }
    },
    null_ls.builtins.diagnostics.shellcheck,
    null_ls.builtins.code_actions.shellcheck
  }
}
