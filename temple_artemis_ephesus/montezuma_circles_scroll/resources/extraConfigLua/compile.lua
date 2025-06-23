local jar_path = "'/home/sieyes/baghdad_plane/flakes/clj-env/clj-env/target/uberjar/clj-env-0.1.0-SNAPSHOT-standalone.jar'"
local function compile()
  local absolute_path = table.concat({"'", vim.fn.expand("%:p"), "'"})
  local command = table.concat({"java", "-jar", jar_path, absolute_path}, " ")
  local ran_command = vim.fn.system(command)
  print("jar-path: ", jar_path)
  print("absolute-path: ", absolute_path)
  print("command: ", command)
  print("ran_command: ", ran_command)
  return ran_command
end
vim.keymap.set("n", "<leader>e$c", compile)
