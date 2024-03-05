{
  inputs,
  cell,
}:
with inputs.std;
  (lib.dev.mkNixago data.configs.treefmt {
    # TODO: Integration with treefmt flake-parts module?
    # TODO: Find all options.
    # TODO: Find less annoying formatter for Nix configs.
    # TODO: Use nixpkgs-fmt for: **/{nixosModules,packages}/*.nix
    data = {};
  })
  // {
    meta.description = "treefmt: Multi-format code formatter settings";
  }
