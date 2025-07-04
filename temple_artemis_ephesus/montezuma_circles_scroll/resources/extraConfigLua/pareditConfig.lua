
local paredit = require("nvim-paredit")
paredit.setup({
  keys = {

        ["<localleader>@e("] = { function() paredit.api.wrap_enclosing_form_under_cursor("(", ")") end, "Wrap enclosing form in parens" },

        ["<localleader>@e["] = { function() paredit.api.wrap_enclosing_form_under_cursor("[", "]") end, "Wrap enclosing form in brackets" },
        ["<localleader>@e{"] = { function() paredit.api.wrap_enclosing_form_under_cursor("{", "}") end, "Wrap enclosing form in brackets" },

        ["<localleader>@l("] = { function() paredit.api.wrap_element_under_cursor("(", ")") end, "Wrap enclosing form in parens" },

        ["<localleader>@l["] = { function() paredit.api.wrap_element_under_cursor("[", "]") end, "Wrap enclosing form in brackets" },
        ["<localleader>@l{"] = { function() paredit.api.wrap_element_under_cursor("{", "}") end, "Wrap enclosing form in brackets" },
        ["<localleader>@@u"] = { paredit.unwrap.unwrap_form_under_cursor, "Splice sexp" },

	  ["("] = {
      paredit.api.move_to_parent_form_start,
      "Jump to parent form's head",
      repeatable = false,
      mode = { "n", "x", "v" },
    },
    [")"] = {
      paredit.api.move_to_parent_form_end,
      "Jump to parent form's tail",
      repeatable = false,
      mode = { "n", "x", "v" },
    },
  }
})
