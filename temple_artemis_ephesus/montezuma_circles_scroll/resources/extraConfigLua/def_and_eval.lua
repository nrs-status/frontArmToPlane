local stdlib
package.preload["stdlib"] = package.preload["stdlib"] or function(...)
  local M = {}
  local function comp1(f, g)
    local function _1_(x)
      return f(g(x))
    end
    return _1_
  end
  M.id = function(x)
    return x
  end
  M.comp = function(...)
    local init = M.id
    for _i, val in ipairs({...}) do
      init = comp1(init, val)
    end
    return init
  end
  return M
end
stdlib = require("stdlib")
local paredit = require("nvim-paredit")
local eval = require("conjure.eval")
local function def_and_eval()
  local saved_pos = vim.api.nvim_win_get_cursor(0)
  paredit.api.select_in_top_level_form()
  vim.cmd("normal! \27")
  vim.cmd("normal! e")
  eval["current-form"]()
  vim.cmd("normal! %ww")
  eval.word()
  vim.api.nvim_win_set_cursor(0, saved_pos)
  return 0
end
vim.keymap.set("n", "<leader>ed", def_and_eval)
