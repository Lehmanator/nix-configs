{ self, inputs
, config, lib, pkgs
, editor ? "nixvim"
, ...
}:
{
  imports = [
    ./neovim.nix
  ];

  # --- Default Editor ---
  #programs.neovim.defaultEditor = editor == "neovim";
  #programs.nixvim.defaultEditor = editor == "nixvim";
  #programs.vim.defaultEditor    = editor == "vim";
  #services.emacs.defaultEditor  = editor == "emacs";

}
