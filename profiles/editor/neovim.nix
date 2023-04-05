{ inputs, config, lib, pkgs, ... }: {
  imports = [
    inputs.nixvim.nixosModules.nixvim
    #inputs.neovim-nightly.nixosModules.
  ];

  nixpkgs.overlays = [ 
    #inputs.neovim-nightly.overlays.default
  ];

  environment.sessionVariables."EDITOR" = "nvim";

  programs.neovim.withNodeJs = true;
  programs.neovim.withPython3 = true;
  programs.neovim.withRuby = true;
  programs.neovim.configure = {
    packages.all.start = with pkgs.vimPlugins; [
      #(nvim-treesitter.withPlugins (ps: [ ps.nix ]))
      # -- OR --
      nvim-treesitter.withAllGrammars  # to install all treesitter grammars (incl. nix)
    ];
  };

  programs.nixvim.enable = true;

  programs.nixvim.options = {
    number = true;
    relativeNumber = true;
    shiftwidth = 2;
  };

  programs.nixvim.plugins = {
    lsp.enable = true;
    lualine.enable = true;

  };

  programs.nixvim.viAlias = true;
  programs.nixvim.vimAlias = true;
}
