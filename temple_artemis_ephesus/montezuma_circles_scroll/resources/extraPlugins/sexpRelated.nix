{ inputs, ... }:
{
  module = {
    extraPlugins = with inputs.pkgs.vimPlugins; [
      vim-sexp vim-sexp-mappings-for-regular-people
    ];
  };
}
