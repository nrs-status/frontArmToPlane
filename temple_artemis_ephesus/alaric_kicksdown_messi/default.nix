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
      for file in "$out"/bin/*; do
        if [[ -f "$file" ]]; then
          wrapProgram $file \
            --prefix PATH : "${pkgs.lib.makeBinPath [ pkgs.fzf ]}"
        fi
      done
    '';
  };
}; in lclInputs.prelib.wrapDebug {
    inherit total activateDebug;
  }
