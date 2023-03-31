{
  self,
  system,
  userPrimary,
  inputs,
  config, lib, pkgs,
  ...
}:
{
  imports = [
    #./shell.nix
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableBashCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    syntaxHighlighting.highlighters = [ "main" "brackets" "cursor" "line" ];
    vteIntegration = true;
  };
  programs.starship.enable = true;

  users.defaultUserShell = pkgs.zsh;
}
