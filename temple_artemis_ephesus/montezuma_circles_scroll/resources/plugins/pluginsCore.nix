{ lclInputs, types, activateDebug ? false, ... }:
with lclInputs;
with types;
let total = rec {
  final = tc PluginSlice tcInput;
  tcInput = {

    #find-next-character motion
    hop = {
      enable = true;
    };

    telescope = {
      enable = true;
      extensions.fzf-native.enable = true;
    };

    #colored brackets, parentheses, etc.
    rainbow-delimiters.enable = true;

    #automatic nix indentation, filetype detection for .nix files, syntax highlighting for nix
    nix.enable = true;

    #automatically set expandtab (enables spaces instead of tabs) and shiftwidth (amount of whitespace to add or remove when an indentation command is called) automatically
    sleuth.enable = true;

    #commands to add/remove/replace brackets, parenthesis, etc. in combination with motion commands
    surround.enable = false;

    auto-save.enable = true;

    #pre-existing snippets collection
    friendly-snippets.enable = true;

    #snippets engine
    luasnip = {
      enable = true;
      fromLua = [
        {paths = ../snippets;}
      ];
      fromSnipmate = [
        {}
        {paths = ../snippets;}
      ];
    };

    # git integrations
    gitsigns.enable = true;

    #add indentation guides
    indent-blankline = {
      enable = true;
      settings = {
        exclude = {
          buftypes = ["terminal" "nofile"];
          filetypes = ["help"];
        };
      };
    };

    #status line
    lualine.enable = true;

    #magit-like git interface
    neogit.enable = true;

    #debug adapter protocol client
    dap = {
      enable = true;
      extensions = {
        dap-python.enable = true;
      };
    };

    treesitter = {
      enable = true;
      indent = true;
    };

    #add context at the top of the window, wherever you are
    treesitter-context = {
      enable = false;
      settings = {
        max_lines = 5;
      };
    };

    #folding
    nvim-ufo = {
      enable = true;
      openFoldHlTimeout = 0;
      providerSelector = ''
        function()
          return { "lsp", "indent" }
        end
      '';
    };

    #lsp improvements and prettification
    lspsaga.enable = true;

    conform-nvim = {
      enable = true;
      autoLoad = true;
      formattersByFt = {
        fennel = ["fnlfmt"];
        clojure = ["cljfmt"];
        haskell = ["ormolu"];
        javascript = ["prettierd"];
        javascriptreact = ["prettierd"];
        typescript = ["prettierd"];
        typescriptreact = ["prettierd"];
        python = ["black"];
        lua = ["stylua"];
        markdown = ["prettierd"];
        nix = ["nixfmt"];
        html = ["rustywind" "stylelint" "htmlbeautifier"];
        css = ["stylelint"];
        bash = ["beautysh"];
        cabal = ["cabal_fmt"];
        json = ["fixjson"];
        yaml = ["yamlfmt"];
        ocaml = ["ocamlformat"];
      };
    };

    #adds pictograms to lsp
    lspkind.enable = true;
  };

}; in prelib.wrapDebug {
  inherit total activateDebug;
}
