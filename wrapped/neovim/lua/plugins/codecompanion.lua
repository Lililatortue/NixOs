return {
      "codecompanion.nvim",
      cmd = {
            "CodeCompanion",
            "CodeCompanionChat",
            "CodeCompanionActions",
            "CodeCompanionToggle",
      },
      keys = {
            { "<C-a>", mode = { "n", "v" } },
            { "<Leader>a", mode = { "n", "v" } },
      },
      dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
      },
      after = function()
            require("codecompanion").setup({
                  ignore_warnings = true,
                  strategies = {
                        chat = {
                              adapter = "gemini",
                        },
                        inline = {
                              adapter = "gemini",
                        },
                  },
                  adapters = {
                        gemini = function()
                              return require("codecompanion.adapters").extend("gemini", {
                              schema = {
                                    model = {
                                          default = "gemini-1.5-pro-latest",
                                    },
                              },
                              })
                        end,
                  },
            })
            vim.keymap.set({ "n", "v" }, "<C-a>", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
            vim.keymap.set({ "n", "v" }, "<Leader>a", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })
            vim.keymap.set("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true })
            vim.cmd([[cab cc CodeCompanion]])
      end,
}

