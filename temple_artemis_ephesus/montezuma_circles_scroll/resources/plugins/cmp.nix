{ lclInputs, types, system, activateDebug ? false, ... }:
with lclInputs;
with types;
let
  total = rec {
    final = tc PluginSlice tcInput;
    tcInput = {
      cmp = {
        enable = true;
        autoEnableSources = true;
        settings = {
          mapping = {
            __raw = ''
              cmp.mapping.preset.insert({
              ['<C-j>'] = cmp.mapping.select_next_item(),
              ['<C-k>'] = cmp.mapping.select_prev_item(),
              ['<C-c>'] = cmp.mapping.abort(),

              ['<C-b>'] = cmp.mapping.scroll_docs(-4),

               ['<C-w>'] = cmp.mapping.scroll_docs(4),

               ['<C-Space>'] = cmp.mapping.complete(), --invokes completion


               ['<C-CR>'] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
              })
            '';
          };
          sources = [
            { name = "cmdline"; }
            { name = "kitty"; }
            { name = "path"; }
          ];
        };
      };

      cmp-cmdline.enable = true;
      cmp-nvim-lsp.enable = true;
      cmp-nvim-lua.enable = true;
      cmp-rg.enable = true;
      cmp-treesitter.enable = true;
      cmp-zsh.enable = true;
      cmp-path.enable = true;
      cmp_luasnip.enable = true;
    };
  };
in prelib.wrapDebug { inherit total activateDebug; }
