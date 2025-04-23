{ inputs, ... }:
inputs.libs.typechecklib.tc {
  typeName = "PluginSlice";
  total.final = { ts-autotag = {
    enable = true;
  };

  colorizer = {
    enable = true;
    userDefaultOptions = {
      css = true;
      tailwind = true;
    };
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
}
