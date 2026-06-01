return {
  'telescope.nvim',
  tag = '0.1.8', -- Use the latest stable release
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local telescope = require('telescope')
    -- Optional configuration
    telescope.setup({
      defaults = {
        mappings = {
          i = {
            -- Custom insert mode mappings if you want them
          },
        },
      },
    })

    -- Set your keymap here
    -- 'n' means Normal mode
    -- '<leader>f' is your trigger
    vim.keymap.set('n', '<leader>f', require('telescope.builtin').find_files, { desc = 'Telescope Find Files' })
  end
}
