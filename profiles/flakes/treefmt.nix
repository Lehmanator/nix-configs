{inputs, ...}: {
  imports = [inputs.treefmt-nix.flakeModule];
  perSystem = {
    config,
    lib,
    pkgs,
    ...
  }: {
    treefmt = {
      projectRootFile = "flake.nix";
      programs = {
        nixfmt.enable = true;
        nixpkgs-fmt.enable = true;
      };
      settings.formatter = {
        nixpkgs-fmt.includes = [
          #"../darwin/packages"
          #"../hm/packages"
          #"../../pkgs/darwin"
          #"../../pkgs/hm"
          "../../pkgs/nixos"
        ];
        nixfmt.excludes = ["../pkgs/nixos" "../../cells"];
      };
    };
  };
}
