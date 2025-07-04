
local paredit = require("nvim-paredit")
paredit.setup({
  keys = {
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
