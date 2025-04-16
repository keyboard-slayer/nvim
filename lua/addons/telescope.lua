return {
  'nvim-telescope/telescope.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
    vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

    -- Lsp Stuff
    vim.keymap.set('n', 'gd', require("telescope.builtin").lsp_definitions)
    vim.keymap.set('n', 'gr', require("telescope.builtin").lsp_references)
    vim.keymap.set('n', 'gi', require("telescope.builtin").lsp_implementations)
  end
}
