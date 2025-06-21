with builtins;
rec {
  prs = getFlake "github:nrs-status/peachRampSkateboard";
  tc = prs.tclib.tc;
  tcf = prs.tclib.tcf;
  pkgs = tcf _ _ _
}
