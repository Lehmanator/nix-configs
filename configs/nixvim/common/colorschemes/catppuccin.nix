{ self
, inputs
, config
, lib
, pkgs
, ...
}:
{
  programs.nixvim.colorschemes.catppuccin = {
    # TODO: All integrations
    integrations.treesitter = config.programs.nixvim.plugins.treesitter.enable;
    integrations.treesitter_context = config.programs.nixvim.plugins.treesitter-context.enable;
  };
}
