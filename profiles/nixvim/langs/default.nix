{
  pkgs,
  config,
  lib,
  ...
}: {
  imports = [
    #./bash.nix
    #./c.nix
    #./cpp.nix
    ./go.nix
    #./javascript.nix
    #./kotlin.nix
    ./latex.nix
    ./markdown.nix
    ./nix.nix
    ./perl.nix
    ./python.nix
    ./rust.nix
    ./sql.nix
    #./typescript.nix
    #./zsh.nix
  ];
  plugins = {
    plantuml-syntax.enable = true; # PlantUML diagram syntax
    zig.enable = true; # Zig language syntax
  };
}
