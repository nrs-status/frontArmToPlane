{ pkgs }:
{
  module = {
    extraPlugins = with pkgs.vimPlugins; [
      vim-sexp vim-sexp-mappings-for-regular-people
    ];
  };
}
