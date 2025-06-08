{ lclInputs, pkgs, system, types, activateDebug ? false }:
  let total = rec {
  final = pkgs.stdenv.mkDerivation {
    name = "alaric_kicksdown_messi";
    src = ./src;
    nativeBuildInputs = [ pkgs.makeWrapper ];
    buildInputs = with pkgs; [ fzf ];
    phases = ["installPhase" "fixupPhase"];
    installPhase = ''
      mkdir -p $out/bin
      cp -r $src/* $out/bin
    '';
    fixupPhase = ''
      ls $out/bin
      echo hi
      for file in $out/bin; do
        echo $file
      done
    '';
  };
}; in lclInputs.prelib.wrapDebug {
    inherit total activateDebug;
  }
