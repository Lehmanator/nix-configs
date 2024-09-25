{ config, lib, pkgs, ... }: 
{
  programs.bash = {
    enableVteIntegration = true;
    historyControl = ["ignorespace"];
  };
}
