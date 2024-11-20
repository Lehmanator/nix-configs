{ config, lib, pkgs, ... }:
{
  imports = [
    ./markdown.nix
    ./rust.nix
  ];
  
  programs.helix = {
    languages = {
      language-server = {
        nil.command = "${pkgs.nil}/bin/nil";
      };
      language = [
        { name = "nix";  auto-format = false; }
      ];
    };
  };
}
