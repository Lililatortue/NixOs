vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'LSP Actions and Keymaps',
    callback = function(args)
        local bufnr = args.buf
        local opts = { noremap = true, silent = true, buffer = bufnr }

        -- The exact shortcuts you want
        vim.keymap.set('v', 'F', vim.lsp.buf.format, opts)
        vim.keymap.set('n', '<leader>d', vim.lsp.buf.format, opts)
        vim.keymap.set('n', '<leader>k', vim.diagnostic.open_float, opts) -- Lowercase k
        vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)
        vim.keymap.set('n', 'gD', vim.lsp.buf.type_definition, opts)
    end,
})

return {
    "nvim-lspconfig",
    lazy = false,

      config = function()
            vim.lsp.config('*', {
                  capabilities = require("blink.cmp").get_lsp_capabilities(),
           })
      end,
}
