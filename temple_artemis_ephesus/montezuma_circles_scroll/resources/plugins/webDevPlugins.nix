{ lclInputs, types, activateDebug ? false, ... }:
with types;
with lclInputs;
let total = rec {
  final = tc PluginSlice tcInput;
  tcInput = { ts-autotag = {
    enable = true;
  };

  colorizer = {
    enable = true;
    settings.filetypes = [
      "css"
    ];
  };

  #color picker and highlighter
  ccc = {
    enable = true;
    settings = {
      highlighter = {
        auto_enable = false;
      };
    };
  };

  lsp.servers = {
      tailwindcss.enable = true;
    cssls.enable = true;
    html.enable = true;

    phpactor.enable = true;
    tsserver.enable = true;
    eslint.enable = true;
  };
};
}; in baselib.wrapDebug {
  inherit total activateDebug;
}
