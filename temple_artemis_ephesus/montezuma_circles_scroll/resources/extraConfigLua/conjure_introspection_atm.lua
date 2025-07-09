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
local function reset_introspection_atm_to_empty_vec()
  local function _3_(_r)
    return print("introspection-atm resetted to []")
  end
  return client["with-filetype"]("clojure", eval["eval-str"], {origin = "introspection-atm", code = "(reset! introspection-atm [])", ["on-result"] = _3_, ["passive?"] = false})
end
local function cursor_on_paren_3f()
  local cursor_pos = vim.api.nvim_win_get_cursor(0)
  local row = (cursor_pos[1] - 1)
  local col = cursor_pos[2]
  local line = vim.api.nvim_buf_get_lines(0, row, (row + 1), false)
  local char
  if ((#line > 0) and (col >= 0) and (col < #line[1])) then
    char = string.sub(line[1], (col + 1), (col + 1))
  else
    char = nil
  end
  if char then
    return ((char == "(") or (char == ")"))
  else
    return false
  end
end
local function mk_wrapper_for_eval(target, action)
  return ("(fn [x] (do " .. action .. " (" .. target .. " x)))")
end
local function eval_w_introspection_atm(string_to_eval)
  local esc_key = vim.api.nvim_replace_termcodes("<Esc>", true, false, true)
  local leader_key = vim.api.nvim_replace_termcodes("<leader>", true, false, true)
  if not inited_3f then
    inited_3f = true
    initialize_introspection_atm()
  else
  end
  vim.api.nvim_feedkeys("vaf\"ay", "x", false)
  vim.api.nvim_feedkeys("vafc", "x", false)
  vim.api.nvim_put({string_to_eval}, "c", true, true)
  def_and_eval()
  return vim.api.nvim_feedkeys((leader_key .. "er" .. "vafc" .. esc_key .. "\"ap"), "x", false)
end
local function eval_replacing_w_conj_21()
  return eval_w_introspection_atm("(fn [x] (conj! introspection-atm x))")
end
local function eval_replacing_w_reset_21()
  return eval_w_introspection_atm("(fn [x] (reset! introspection-atm x))")
end
local eval_options = {"(fn [x] (do (conj! introspection-atm x) (_ x)))", "(fn [x] (do (reset! introspection-atm x) (_ x)))"}
local function print_introspection_atm()
  local function _7_(r)
    return print("RESULT:", r)
  end
  return client["with-filetype"]("clojure", eval["eval-str"], {origin = "introspection-atm", code = "@introspection-atm", ["on-result"] = _7_, ["passive?"] = false})
end
vim.keymap.set("n", "<leader>eiwc", eval_replacing_w_conj_21)
vim.keymap.set("n", "<leader>eiwr", eval_replacing_w_reset_21)
vim.keymap.set("n", "<leader>eip", print_introspection_atm)
vim.keymap.set("n", "<leader>eie", reset_introspection_atm_to_empty_vec)
vim.keymap.set("n", "<leader>eii", initialize_introspection_atm)
