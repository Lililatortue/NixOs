local function config()
  local ls = require("luasnip")

  local s   = ls.snippet
  local sn  = ls.snippet_node
  local t   = ls.text_node
  local i   = ls.insert_node 
  local c   = ls.choice_node
  local rep = require("luasnip.extras").rep


    ls.add_snippets("rust",{
      s("fn", {
        t("fn "),
        i(1, "foo"),
        t("("), i(2, "bar: usize"), t(")"),
        c(3, {
          t(""),
          sn(nil, { t("-> "), i(1, "usize") }),
        }),
        t(" {\n\t"),
        i(4), 
        t("\n}\n"),
        i(0)
      }),

      s("struct", {
        c(1, {
          t("pub "),
          t(""),
        }),
        t("struct "), i(2, "Foo"), t(" {","      "),
        i(3, "bar: usize"),
        t("\n}\n\n"),
        c(4, {
          t(""),
          sn(nil, {
            t("impl "), rep(2), t(" {","      "),
            i(1, "pub fn new() {","          \n      }"),
            t("\n}\n")
          })
        })
      }),
    })

    ls.add_snippets("python", {
      s("fn", {
        t("def "), i(1, "foo"),
        t("("), i(2, "bar"), t(")"),
        c(3, {
          t(""),
          sn(nil, { t("-> "), i(1, "int") })
        }),
        t({":","    "}),
        i(4, "pass"),
        t({"",""}),
        i(0),
      }),
    })
 -- Dynamic augroup for snippet-local handling
 local luasnip_keys_group = vim.api.nvim_create_augroup("LuaSnipDynamicKeys", { clear = true })

  -- 1. WHEN ENTERING A SNIPPET: Bind double-tap navigation
  vim.api.nvim_create_autocmd("User", {
    pattern = { "LuasnipSnippetEnter", "LuasnipNodeEnter" },
    group = luasnip_keys_group,
    callback = function()
      local opts = { buffer = 0, silent = true }

      -- 'll' jumps forward to the next placeholder
      vim.keymap.set({"i", "s"}, "ll", function() ls.jump(1) end, opts)
      
      -- 'hh' jumps backward to the previous placeholder
      vim.keymap.set({"i", "s"}, "hh", function() ls.jump(-1) end, opts)
      
      -- 'jj' cycles forward through Choice Nodes (like return types)
      vim.keymap.set({"i", "s"}, "jj", function()
        if ls.choice_active() then
          ls.change_choice(1)
        else
          -- Fallback: If not a choice node, type 'jj' literally
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("jj", true, false, true), "n", true)
        end
      end, opts)
      
      -- 'kk' cycles backward through Choice Nodes
      vim.keymap.set({"i", "s"}, "kk", function()
        if ls.choice_active() then
          ls.change_choice(-1)
        else
          -- Fallback: If not a choice node, type 'kk' literally
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("kk", true, false, true), "n", true)
        end
      end, opts)
    end,
  })

  -- 2. WHEN LEAVING A SNIPPET: Tear down double-tap maps immediately
  vim.api.nvim_create_autocmd("User", {
    pattern = { "LuasnipSnippetLeave" },
    group = luasnip_keys_group,
    callback = function()
      pcall(vim.keymap.del, {"i", "s"}, "ll", { buffer = 0 })
      pcall(vim.keymap.del, {"i", "s"}, "hh", { buffer = 0 })
      pcall(vim.keymap.del, {"i", "s"}, "jj", { buffer = 0 })
      pcall(vim.keymap.del, {"i", "s"}, "kk", { buffer = 0 })
    end,
  })
end

return {
  "luasnip",
   after = config
}

