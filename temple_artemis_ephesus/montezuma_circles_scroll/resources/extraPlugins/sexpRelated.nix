{ lclInputs, ... }:
{
  module = {
    extraPlugins = with lclInputs.pkgs.vimPlugins; [
      vim-sexp vim-sexp-mappings-for-regular-people
    ];
  };
}
