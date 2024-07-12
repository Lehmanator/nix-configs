{ self, inputs
, config, lib, pkgs
, editor ? "nixvim"
, ... }: {
  imports = [
    #inputs.home-extra-xhmm.homeManagerModules.console.nano
    ./editorconfig.nix
    ./helix
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
