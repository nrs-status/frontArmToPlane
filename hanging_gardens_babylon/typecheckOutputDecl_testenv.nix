with builtins;
rec {
  prs = getFlake "github:nrs-status/peachRampSkateboard";
  pkgs = import <nixpkgs> { system = "x86_64-linux"; };
  pkgslib = pkgs.lib;
  prelib = prs.prelib;
  tclib = prs.tclib;
  tc = tclib.tc;
  target = {
    nixpkgs = {};
    nixpkgsConfig = [ "hi"];
    supportedSystems = ["mysys"];
    envsToProvide = ["envs"];
    packagesToProvide = ["pkgs"];
    lclInputs = x: x;
    types = x: x;
  };
  result = tc tclib.types.OutputDecl target;
}
