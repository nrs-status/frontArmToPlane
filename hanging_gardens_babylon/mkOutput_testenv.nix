with builtins;
{
  flakes = {
    nixpkgsUnstable = getFlake "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs2411 = getFlake "github:NixOS/nixpkgs/nixos-24.11";
    nixvimFlake = getFlake = "github:nix-community/nixvim";
  };

}
