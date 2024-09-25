{ config, lib, pkgs, ... }:
{
  programs.helix = {
    extraPackages = [
      pkgs.markdown-oxide
      pkgs.marksman
      pkgs.mdformat
    ];
    languages = {
      language-server = {
        markdown-oxide.command = lib.getExe pkgs.markdown-oxide;
        marksman.command = lib.getExe pkgs.marksman;
      };
      language = [{
         name = "markdown";
         auto-format = true;
         formatter.command = "${pkgs.mdformat}/bin/mdformat";
      }];
    };
  };
}
