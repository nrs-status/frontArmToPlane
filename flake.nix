{
  inputs = {
    nixpkgs.url = "github:NixOs/nixpkgs/nixos-unstable";
    nixvimFlakeInput.url = "github:nix-community/nixvim";
    lighthouseAlexandria.url = "github:nrs-status/lighthouseAlexandria";
  };

  outputs = inputs: 
    let 
      output1 = {
	#although it looks like we're just repeating the inputs, the idea is to make it easy to create new output blocks with different inputs, in case we need new packages but don't have time to update everything 
        inputs = {
	  nixpkgs = inputs.nixpkgs;
	  nixvimFlakeInput = inputs.nixvimFlakeInput;
	};
        supportedSystems = [
          "x86_64-linux"
        ];
        envsToProvide = envs: with envs; [
          workEnv
        ];
        packagesToProvide = myPkgs: with myPkgs; [
        ];
      };
    in
      inputs.lighthouseAlexandria.lib.mkOutput {
        envsdir = ./pyramid_giza;
        mypkgsdir = ./temple_artemis_ephesus;
        outputsList = [
          output1
        ];
      };

}
