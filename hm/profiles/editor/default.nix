{ inputs
, config, lib, pkgs
, ... }:
{
  imports = [
    #inputs.home-extra-xhmm.homeManagerModules.console.nano
    ./editorconfig.nix
    "${inputs.self}/hm/profiles/helix"
    #./neovim
    #./nixvim
  ];

  # --- Default Editor ---
  #programs.helix.defaultEditor   = editor == "helix";
  #programs.kakoune.defaultEditor = editor == "kakoune";
  #programs.neovim.defaultEditor  = editor == "neovim";
  #programs.nixvim.defaultEditor  = editor == "nixvim";
  #programs.nixvim.defaultEditor  = true;
  #programs.vim.defaultEditor     = editor == "vim";
  #services.emacs.defaultEditor   = editor == "emacs";

}
