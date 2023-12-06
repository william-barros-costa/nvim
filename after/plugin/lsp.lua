local lsp = require('lsp-zero')
require('mason').setup()

lsp.preset('recommended')
lsp.setup()
