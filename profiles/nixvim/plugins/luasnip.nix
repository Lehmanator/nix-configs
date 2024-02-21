{inputs, ...}: {
  # --- Snippets ---------------------
  plugins = {
    cmp_luasnip.enable = true;
    cmp-nvim-ultisnips.enable = false;
    cmp-snippy.enable = false;
    cmp-vsnip.enable = false;
    luasnip = {
      enable = true;
      fromVscode = [
        #{ paths = "${config.xdg.dataHome}/vscode/snippets"; }
        #{ paths = "${config.home.homeDirectory}/.var/app/<FlatpakAppID>/.../snippets"; }
        #{ paths = "${pkgs.vscodium}/.../snippets"; }
      ];
    };
    # TODO: Also set: nvim-cmp.mapping."<Tab>".action to expand snippet.
    # TODO: Abstract out snippet engine name. Make func to call installed snippet engine expansion method.
    nvim-cmp.snippet.expand = "luasnip"; # luasnip | snippy | ultisnips | vsnip | function()
  };
}
