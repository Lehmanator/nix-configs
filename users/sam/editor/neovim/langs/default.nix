{ self, inputs
, ...
}:
{
  imports = [
    #./bash.nix
    #./c.nix
    #./cpp.nix
    #./javascript.nix
    #./kotlin.nix
    ./latex.nix
    ./markdown.nix
    ./nix.nix
    ./perl.nix
    ./python.nix
    ./rust.nix
    #./typescript.nix
    #./zsh.nix
  ];
  programs.nixvim.plugins = {
    plantuml-syntax.enable = true; # PlantUML diagram syntax
    zig.enable = true;             # Zig language syntax
  };
}
