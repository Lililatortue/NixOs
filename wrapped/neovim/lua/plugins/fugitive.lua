return {
      "vim-fugitive",
      lazy = false,
      after= function()
            vim.keymap.set("n", "<leader>gs", "<cmd>Git<cr>", { desc = "Git: Open Summary" })
            local Lili_Fugitive = vim.api.nvim_create_augroup("Lili_Fugitive", {})

            local autocmd = vim.api.nvim_create_autocmd

            autocmd("BufWinEnter", {
                group = Lili_Fugitive,
                pattern = "*",
                callback = function()
                      if vim.bo.ft ~= "fugitive" then
                          return
                      end

                      local bufnr = vim.api.nvim_get_current_buf()
                      local opts = {buffer = bufnr, remap = false}

                      vim.keymap.set("n", "<leader>p", function()
                            vim.cmd.Git('push')
                      end, opts)
                      vim.keymap.set("n", "<leader>P", function()
                          vim.cmd.Git({'pull',  '--rebase'})
                      end, opts)
                      vim.keymap.set("n", "<leader>t", ":Git push -u origin ", opts)

                      vim.keymap.set({ "n", "x" }, "a", "-", {
                            buffer = bufnr,
                            remap = true,
                            desc = "Toggle stage/unstage on cursor"
                      })
                end,
        })


        vim.keymap.set("n", "gu", "<cmd>diffget //2<CR>")
        vim.keymap.set("n", "gh", "<cmd>diffget //3<CR>")
    end
}
