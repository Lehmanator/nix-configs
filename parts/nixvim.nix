{inputs, ...}: {
  perSystem = {
    config,
    pkgs,
    system,
    inputs',
    ...
  }: let
    nixvimModule = {
      inherit pkgs;
      module = import ../profiles/nixvim;
      extraSpecialArgs = {inherit inputs;};
    };
  in {
    checks.nixvim =
      inputs'.nixvim.lib.check.mkTestDerivationFromNixvimModule nixvimModule;
    packages.nvim =
      inputs'.nixvim.legacyPackages.makeNixvimWithModule nixvimModule;
  };
  flake = {nixvimModules = {default = ../profiles/nixvim;};};
}
