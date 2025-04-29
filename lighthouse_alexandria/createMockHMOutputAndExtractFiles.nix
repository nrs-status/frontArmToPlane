{ pkgs, baselib, pkgslib }:
{ elemAtIndex, stateVersion, homeManagerFlake, attrsOfPathsStartingAtPlaceholderHome, mockHomeExtensions, activateDebug ? false, ... }:
#I don't understand how what's at the index given by elemAtArg is determined
with builtins;
let total = rec {
  mockHomeConfig = {
    home = {
      username = "placeholder";
      homeDirectory = "/home/placerholder";
      inherit stateVersion;
    };
  };
  concatedExtensions = foldl' baselib.deepMerge {} mockHomeExtensions;
  homeManagerOutput = homeManagerFlake.lib.homeManagerConfiguration {
    inherit pkgs;
    modules = [ (mockHomeConfig // concatedExtensions) ];
  };
  transformPathsIntoStringsToFetchFiles = mapAttrs (key: val: ".config" + (toString val)) attrsOfPathsStartingAtPlaceholderHome;
  grabMatchingTarget = targetToMatch: acc: next: if next.target == targetToMatch then next else acc;
  toFetchers = mapAttrs (_key: val: grabMatchingTarget val) transformPathsIntoStringsToFetchFiles;
  mockHomeConfigFilesInternalAttrs = attrValues (elemAt homeManagerOutput.options.home.file.definitionsWithLocations elemAtIndex).value; #need to use attrValues because the keys are paths and nix won't accpet a string to acces them
  handler = result: if result == {} then throw ("createMockHMOutputAndExtractFiles.nix: unallowed empty set while fetching files") else result;
  withFetched = mapAttrs (_key: val: handler (foldl' val {} mockHomeConfigFilesInternalAttrs)) toFetchers;
  withFileContents = mapAttrs (_key: val: readFile val.source) withFetched;
  final = withFileContents;
}; in baselib.wrapDebug {
  inherit total activateDebug;
}
