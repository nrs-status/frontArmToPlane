{ lclInputs, pkgs, system, types, activateDebug ? false }:
  let total = rec {
  final = pkgs.mkDerivation {
    name = "alaric_kicksdown_messi";
    src = "./src";
    buildPhase = ''
      mkdir $out/bin
      cp -r $src/* $out/bin"
      '';
    installPhase = "";
  };
}; in lclInputs.prelib.wrapDebug {
    inherit total activateDebug;
  }
