{ inputs
, config, lib, pkgs
, ...
}:
{
  imports = [
    inputs.nixvim.nixosModules.nixvim
    #inputs.neovim-nightly.nixosModules.
  ];

  #environment.sessionVariables."EDITOR" = "nvim";

  nixpkgs.overlays = [
    #inputs.neovim-nightly.overlays.default
  ];

  programs.neovim = {
    withNodeJs = lib.mkDefault true;
    withPython3 = lib.mkDefault true;
    withRuby = lib.mkDefault true;
    configure = {
      packages.all.start = with pkgs.vimPlugins;
        [nvim-treesitter.withAllGrammars]; # Install all treesitter grammars
        # -- OR --
        #[(nvim-treesitter.withPlugins (ps: [ps.nix])]; # Specific grammar pkgs
    };
  };

  programs.nixvim = {
    enable = true;
    options = {
      number = true;
      relativeNumber = true;
      shiftwidth = 2;
    };
    plugins = {
      lsp.enable = true;
      lualine.enable = true;
    };
    viAlias = true;
    vimAlias = true;
  };

}
