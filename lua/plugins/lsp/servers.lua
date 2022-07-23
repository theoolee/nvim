local file_utils = require 'utils.file'
local lspconfig = require 'lspconfig'
local lsp_installer = require 'nvim-lsp-installer'

lsp_installer.setup {
  ensure_installed = {
    'bashls',
    'clangd',
    'cssls',
    'dartls',
    'dockerls',
    'emmet_ls',
    'eslint',
    'gopls',
    'html',
    'jdtls',
    'jsonls',
    'pyright',
    'rust_analyzer',
    'sumneko_lua',
    'taplo',
    'tsserver',
    'volar',
    'vuels',
    'yamlls',
    'zk'
  },
  automatic_installation = true
}

local eslint_patterns = {
  '.eslintrc.js',
  '.eslintrc.cjs',
  '.eslintrc.yaml',
  '.eslintrc.yml',
  '.eslintrc.json'
}

local function is_eslint_project(path)
  return lspconfig.util.search_ancestors(path, function(_path)
    for _, pattern in ipairs(eslint_patterns) do
      if file_utils.exists(_path .. path_separator .. pattern) then
        return true
      end
    end
  end)
end

local function is_vue_project(path)
  local package_json = file_utils.read_json(path .. path_separator .. 'package.json')
  if package_json then
    return (package_json.dependencies and package_json.dependencies.vue) or
        (package_json.devDependencies and package_json.devDependencies.vue)
  end
end

local function is_typescript_project(path)
  local package_json = file_utils.read_json(path .. path_separator .. 'package.json')
  if package_json then
    return (package_json.dependencies and package_json.dependencies.typescript) or
        (package_json.devDependencies and package_json.devDependencies.typescript)
  end
end

local function is_volar_project(path)
  if is_typescript_project(path) and is_vue_project(path) then
    return true
  end
end

local function is_vetur_project(path)
  if not is_typescript_project(path) then
    return true
  end
end

local configs = {
  eslint = {
    root_dir = function(fname)
      local dir = lspconfig.util.find_package_json_ancestor(fname)
      if is_eslint_project(dir) then
        return dir
      end
    end
  },
  tsserver = {
    root_dir = function(fname)
      local dir = lspconfig.util.find_package_json_ancestor(fname)
      if not is_volar_project(dir) then
        return dir
      end
    end
  },
  volar = {
    filetypes = {
      'typescript',
      'javascript',
      'javascriptreact',
      'typescriptreact',
      'vue'
    },
    root_dir = function(fname)
      local dir = lspconfig.util.find_package_json_ancestor(fname)
      if is_volar_project(dir) then
        return dir
      end
    end
  },
  vuels = {
    filetypes = {
      'vue'
    },
    root_dir = function(fname)
      local dir = lspconfig.util.find_node_modules_ancestor(fname)
      if is_vetur_project(dir) then
        return dir
      end
    end
  },
  jsonls = {
    settings = {
      json = {
        schemas = require 'schemastore'.json.schemas(),
        validate = {
          enable = true
        }
      }
    }
  },
  sumneko_lua = vim.tbl_extend('force', require 'lua-dev'.setup(), {
    settings = {
      Lua = {
        workspace = {
          library = vim.api.nvim_get_runtime_file('', true)
        },
        format = {
          defaultConfig = {
            indent_style = 'space',
            indent_size = '2',
            quote_style = 'single',
            call_arg_parentheses = 'remove',
            continuous_assign_statement_align_to_equal_sign = 'false',
            continuous_assign_table_field_align_to_equal_sign = 'false'
          }
        },
        diagnostics = {
          neededFileStatus = {
            ['codestyle-check'] = 'Any'
          }
        }
      }
    }
  })
}

local function select_default_formater(client)
  if client.name == 'null-ls' or not client.server_capabilities.documentFormattingProvider then
    return
  end
  local client_filetypes = client.config.filetypes or {}
  for _, filetype in ipairs(client_filetypes) do
    local sources = require 'null-ls.sources'.get_available(filetype)
    for _, source in ipairs(sources) do
      if source.methods['NULL_LS_FORMATTING'] then
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
        return
      end
    end
  end
end

local servers = lsp_installer.get_installed_servers()
for _, server in ipairs(servers) do
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require 'cmp_nvim_lsp'.update_capabilities(capabilities)
  capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true
  }
  lspconfig[server.name].setup(
    vim.tbl_extend('force',
      {
        on_attach = function(client)
          select_default_formater(client)
          require 'illuminate'.on_attach(client)
        end,
        capabilities = capabilities
      },
      configs[server.name] or {}
    )
  )
end
