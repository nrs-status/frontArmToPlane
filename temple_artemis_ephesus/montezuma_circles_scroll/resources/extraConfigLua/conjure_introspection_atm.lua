local eval = require("conjure.eval")
local client = require("conjure.client")
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
local inited_3f = false
local function initialize_introspection_atm()
  local function _2_(_r)
    return print("introspection-atm INIT")
  end
  return client["with-filetype"]("clojure", eval["eval-str"], {origin = "introspection-atm", code = "(def introspection-atm (atom nil))", ["on-result"] = _2_, ["passive?"] = false})
end
local function eval_w_introspection_atm()
  local esc_key = vim.api.nvim_replace_termcodes("<Esc>", true, false, true)
  if not inited_3f then
    inited_3f = true
    initialize_introspection_atm()
  else
  end
  vim.api.nvim_feedkeys("vaf\"ay", "x", false)
  vim.api.nvim_feedkeys("vafc", "x", false)
  vim.api.nvim_put({"(fn [x] (reset! introspection-atm x))"}, "c", true, true)
  def_and_eval()
  return vim.api.nvim_feedkeys(("vafc" .. esc_key .. "\"ap"), "x", false)
end
local function print_introspection_atm()
  local function _4_(r)
    return print("RESULT:", r)
  end
  return client["with-filetype"]("clojure", eval["eval-str"], {origin = "introspection-atm", code = "@introspection-atm", ["on-result"] = _4_, ["passive?"] = false})
end
vim.keymap.set("n", "<leader>eie", eval_w_introspection_atm)
vim.keymap.set("n", "<leader>eip", print_introspection_atm)
