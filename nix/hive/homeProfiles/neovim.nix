{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: {
  home = {
    sessionVariables.EDITOR = lib.getExe inputs.self.packages.${pkgs.system}.nvim; #"nvim";
    packages = [
      inputs.self.packages.${pkgs.system}.nvim
      pkgs.fd pkgs.universal-ctags
    ];
  };

  programs.git.extraConfig = {
    diff.external = true;
    core.editor = "${lib.getExe inputs.self.packages.${pkgs.system}.nvim}"; # "nvim";
  };
}
