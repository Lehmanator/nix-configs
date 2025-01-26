{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.bash = {
    completion.enable = true;
    enableLsColors = true;
    undistractMe = {
      enable = true;
      playSound = true;
      timeout = 30;
    };
  };

  environment = {
    # Link bash completions. Used by bash & ZSH compat.
    pathsToLink = ["/share/bash-completion"];
    systemPackages = [pkgs.bash];
    shells = [pkgs.bashInteractive];
  };
}
