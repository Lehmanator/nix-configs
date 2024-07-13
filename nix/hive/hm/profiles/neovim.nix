{ cell, inputs, config, lib, pkgs, ... }: 
let
  vim-pkg = pkgs.neovim
      # inputs.cells.vim.packages.nvim
      # inputs.self.packages.${pkgs.system}.nvim
      ;
in
{
  home = {
    sessionVariables.EDITOR = lib.getExe vim-pkg; #"nvim";
    packages = [ pkgs.fd pkgs.universal-ctags vim-pkg ];
  };

  programs.git.extraConfig = {
    diff.external = true;
    core.editor = "${lib.getExe vim-pkg}";
  };
}
