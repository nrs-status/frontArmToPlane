local jar_path = "'/home/sieyes/baghdad_plane/flakes/clj-env/clj-env/target/uberjar/clj-env-0.1.0-SNAPSHOT-standalone.jar'"
local function compile()
  local absolute_path = table.concat("'", vim.fn.expand("%:p"), "'")
  local ran_command = vim.fn.system(table.concat({"java", "-jar", jar_path, absolute_path}, " "))
  return ran_command:wait()
end
vim.keymap.set("n", "<leader>e$c", compile)
