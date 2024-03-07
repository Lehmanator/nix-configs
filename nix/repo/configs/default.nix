{
  inputs,
  cell,
}:
# Nixago Options:
# data = {};
# engine = engines.nix {};
# format = "yaml";
# hook = {}; # Additional options for controlling hook generation
# apply = x: x;  # Apply this transformation to `data`
# output = ../filepath.ext; # Relpath to generated file.
# root = inputs.self; # Root path from which relpath is derived
#let
#  inherit (inputs.std.data) configs;
#  inherit (inputs.std.lib.dev) mkNixago;
#in
{
  conform = import ./conform.nix {inherit inputs cell;}; # configs mkNixago;};
  editorconfig = import ./editorconfig.nix {inherit inputs cell;};
  githubsettings = import ./githubsettings.nix {inherit inputs cell;};
  lefthook = import ./lefthook.nix {inherit inputs cell;};
  mdbook = import ./mdbook.nix {inherit inputs cell;};
  treefmt = import ./treefmt.nix {inherit inputs cell;};

  # adrgen: manage Architecture Decision Records
  # https://github.com/asiermarques/adrgen
  #adrgen = import ./adrgen.nix {inherit inputs cell configs mkNixago;};

  # just: Command runner
  # https://github.com/casey/just
  #just = import ./just.nix {inherit inputs cell configs mkNixago;};

  # prettier: Code style formatter
  # https://prettier.io/
  # https://nix-community.github.io/nixago-extensions/extensions/prettier.html
}
