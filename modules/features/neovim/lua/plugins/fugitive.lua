return {
  "tpope/vim-fugitive",
  cmd = { "G", "Git", "Gdiffsplit", "Gread", "Gwrite", "Ggrep", "GMove", "GDelete", "GBrowse" },
  keys = {
    { "<leader>gs", "<cmd>Git<cr>", desc = "Git Status" },
    { "<leader>gp", "<cmd>Git push<cr>", desc = "Git Push" },
    { "<leader>gl", "<cmd>Git log<cr>", desc = "Git Log" },
    { "<leader>gd", "<cmd>Gdiffsplit<cr>", desc = "Git Diff Split" },
    { "<leader>gb", "<cmd>Git blame<cr>", desc = "Git Blame" },
  },
  config = function()
    local fugitive_group = vim.api.nvim_create_augroup("FugitiveCustom", { clear = true })

    vim.api.nvim_create_autocmd("FileType", {
      group = fugitive_group,
      pattern = "fugitive",
      callback = function()
        local bufnr = vim.api.nvim_get_current_buf()
        local opts = { buffer = bufnr, remap = false }

        vim.keymap.set("n", "<leader>p", function()
          vim.cmd.Git("push")
        end, vim.tbl_extend("force", opts, { desc = "Git Push" }))

        vim.keymap.set("n", "<leader>P", function()
          vim.cmd.Git("pull --rebase")
        end, vim.tbl_extend("force", opts, { desc = "Git Pull Rebase" }))
        
        vim.g.fugitive_summary_format = "%as: %s (%an)"
      end,
    })
  end,
}
