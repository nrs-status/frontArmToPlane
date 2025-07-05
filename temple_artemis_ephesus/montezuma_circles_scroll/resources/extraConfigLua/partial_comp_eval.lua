local def_and_eval
package.preload["def_and_eval"] = package.preload["def_and_eval"] or function(...)
  local stdlib = require("stdlib")
  local paredit = require("nvim-paredit")
  local eval = require("conjure.eval")
  local function def_and_eval()
    local saved_pos = vim.api.nvim_win_get_cursor(0)
    local esc_key = vim.api.nvim_replace_termcodes("<Esc>", true, false, true)
    paredit.api.select_in_top_level_form()
    vim.api.nvim_feedkeys((esc_key .. "e"), "nx", false)
    eval["current-form"]()
    vim.api.nvim_feedkeys("%ww", "nx", false)
    eval.word()
    vim.api.nvim_win_set_cursor(0, saved_pos)
    return 0
  end
  vim.keymap.set("n", "<leader>ed", def_and_eval)
  return def_and_eval
end
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
def_and_eval = require("def_and_eval")
local function line_has_comp_3f()
  local current_line = vim.api.nvim_get_current_line()
  return (nil ~= string.match(current_line, "%f[%w]comp%f[%W]"))
end
local function toggle_comment_up_to_comp_then_come_back()
  local saved_pos = vim.api.nvim_win_get_cursor(0)
  vim.api.nvim_feedkeys("k", "x", false)
  local function this()
    if line_has_comp_3f() then
      return vim.api.nvim_win_set_cursor(0, saved_pos)
    else
      vim.api.nvim_feedkeys("gcck", "x", false)
      return this()
    end
  end
  return this()
end
local function eval_comp_up_to_current_line()
  toggle_comment_up_to_comp_then_come_back()
  def_and_eval()
  return toggle_comment_up_to_comp_then_come_back()
end
vim.keymap.set("n", "<leader>ec", eval_comp_up_to_current_line)
