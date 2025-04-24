{ inputs, system, activateDebug ? false }:
let total = rec {
  composition = inputs.pkgs.androidenv.composeAndroidPackages {
    cmdLineToolsVersion = [
      "17.0"
    ];
    platformVersions = [
      "35"
    ];
    buildToolsVersions = [
      "34"
    ];
    systemImageTypes = [ "google_apis_playstore" ];
    abiVersions = [
      "x86_64"
    ];
  includeEmulator = true;
  emulatorVersion = "35.6.2";
  };
  final = composition;

}; in inputs.baselib.wrapDebug {
  inherit total activateDebug;
}
