{ inputs, config, lib, pkgs, ... }: {
  imports = [
    inputs.nixvim.nixosModules.nixvim
    #inputs.neovim-nightly.nixosModules.
  ];

  nixpkgs.overlays = [ 
    #inputs.neovim-nightly.overlays.default
  ];

  environment.sessionVariables."EDITOR" = "nvim";
  environment.systemPackages = with pkgs; [
    neovim
  ];

  programs.neovim.enable = true;
  programs.neovim.defaultEditor = true;
  programs.neovim.withNodeJs = true;
  programs.neovim.withPython3 = true;
  programs.neovim.withRuby = true;
  programs.neovim.viAlias = true;
  programs.neovim.vimAlias = true;
  programs.neovim.configure = {
    packages.all.start = with pkgs.vimPlugins; [
      #(nvim-treesitter.withPlugins (ps: [ ps.nix ]))
      # -- OR --
      nvim-treesitter.withAllGrammars  # to install all treesitter grammars (incl. nix)
    ];
  };
}
