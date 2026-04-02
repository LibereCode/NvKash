return { -- INFO: this file handles the CORE PLUGS
  require 'configs.lsp', -- language server
  require 'configs.conform', -- format
  require 'configs.blink', -- autosuggestions
  require 'kickstart.plugins.lint', -- diagnostics

  require 'configs.theme', -- Change colortheme here !!
}
