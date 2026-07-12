return {
  "oil.nvim",
      lazy = false;

      after = function()
        -- pretty print directory
        function _G.get_oil_winbar()
              local bufnr = vim.api.nvim_win_get_buf(vim.g.statusline_winid)
              local dir = require("oil").get_current_dir(bufnr)

              if dir then
                    return vim.fn.fnamemodify(dir, ":~")
              else
                    return vim.api.nvim_buf_get_name(0)
              end
        end

        if vim.bo.buftype ~= "" then
            vim.notify("In a Git/Special buffer — closing Oil trigger", vim.log.levels.INFO)
            return
        end

        require("oil").setup({
              win_options = {
                    winbar = "%!v:lua.get_oil_winbar()",
              },
              keymaps = {
                    ["<leader>a"] = "actions.toggle_hidden",
                    ["L"] = "actions.select",
                    ["H"] = "actions.parent"
              },
        })
        vim.keymap.set("n", "<leader>e", function()
              if vim.bo.buftype ~= ""  then
                    vim.notify("In a Special buffer — closing Oil trigger", vim.log.levels.INFO)
                    return
              end
              require("oil").open()
        end, { desc = "Open Oil" })
      end,
}

