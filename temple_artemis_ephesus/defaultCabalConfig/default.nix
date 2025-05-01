{ pkgs, ... }:
with builtins;
pkgs.writeTextFile {
  name = "defaultCabalConfig";
  text = readFile ./config;
}
