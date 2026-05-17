local function config()
  local ls = require("luasnip")

  local s   = ls.snippet
  local sn  = ls.snippet_node
  local t   = ls.text_node
  local i   = ls.insert_node 
  local c   = ls.choice_node
  local rep = require("luasnip.extras").rep

  ls.snippets = {
    all  = {},

    rust = {
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
        t("struct "), i(2, "Foo"), t(" {\n      "),
        i(3, "bar: usize"),
        t("\n}\n\n"),
        c(4, {
          t(""),
          sn(nil, {
            t("impl "), rep(2), t(" {\n      "),
            i(1, "pub fn new() {\n          \n      }"),
            t("\n}\n")
          })
        })
      }),
    },

    python = {
      s("fn", {
        t("def "), i(1, "foo"),
        t("("), i(2, "bar"), t(")"),
        c(3, {
          t(""), 
          sn(nil, { t(" -> "), i(1, "int") }) 
        }),
        t(":\n    "),
        i(4, "pass"), 
        t("\n"),
        i(0),
      }),
    },
  }
end

return {
  "luasnip", 
  lazy = false,
  config = config     
}

