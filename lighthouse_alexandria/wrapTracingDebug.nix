{ total, attrsToTrace, activateDebug ? false}:
with builtins;
(import ./withDebug.nix) activateDebug {
  debug = let 
    tracings = map (attrName: trace "tracing total's ${attrName}: " (trace total.${attrName} {})) attrsToTrace;
  in seq tracings total.final;
  nondebug = total.final;
}
