{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: {
  home = {
    sessionVariables.EDITOR = "nvim";
    packages = [
      pkgs.fd
      pkgs.universal-ctags
    ];
  };

  programs.git.extraConfig = {
    diff.external = true;
    core.editor = "${lib.getExe
      inputs.self.packages.${pkgs.system}.nixvim-wrapped}"; # "nvim";
  };

}
