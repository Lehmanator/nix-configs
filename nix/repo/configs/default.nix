{
  inputs,
  cell,
}: let
  inherit (inputs.std.data) configs;
  inherit (inputs.std.lib.dev) mkNixago;
  # Nixago Options:
  # data = {};
  # engine = engines.nix {};
  # format = "yaml";
  # hook = {}; # Additional options for controlling hook generation
  # apply = x: x;  # Apply this transformation to `data`
  # output = ../filepath.ext; # Relpath to generated file.
  # root = inputs.self; # Root path from which relpath is derived
in {
  # adrgen: manage Architecture Decision Records
  # https://github.com/asiermarques/adrgen
  #adrgen = import ./adrgen.nix {inherit inputs cell configs mkNixago;};

  conform =
    #mkNixago configs.conform
    import ./conform.nix {inherit inputs cell;}; # configs mkNixago;};

  editorconfig =
    #mkNixago configs.editorconfig
    import ./editorconfig.nix {inherit inputs cell;};

  githubsettings =
    #mkNixago configs.githubsettings
    (import ./githubsettings.nix {inherit inputs cell;});

  # just: Command runner
  # https://github.com/casey/just
  #just = import ./just.nix {inherit inputs cell configs mkNixago;};

  lefthook =
    #mkNixago configs.lefthook
    (import ./lefthook.nix {inherit inputs cell;});

  mdbook =
    #mkNixago configs.mdbook
    (import ./mdbook.nix {inherit inputs cell;});

  # prettier: Code style formatter
  # https://prettier.io/
  # https://nix-community.github.io/nixago-extensions/extensions/prettier.html
  treefmt =
    #mkNixago configs.treefmt
    (import ./treefmt.nix {inherit inputs cell;});
}
