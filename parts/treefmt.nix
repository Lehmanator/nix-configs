{
  inputs,
  self,
  ...
}: {
  imports = [inputs.treefmt-nix.flakeModule];
  perSystem = {
    config,
    lib,
    pkgs,
    ...
  }: {
    treefmt = {
      #package = pkgs.treefmt;
      projectRootFile = "flake.nix";
      programs = {
        nixfmt.enable = true;
        nixpkgs-fmt.enable = true;
      };
      settings.formatter = {
        nixpkgs-fmt.includes = [
          #"../darwin/packages"
          #"../hm/packages"
          "../nixos/packages"
        ];
        nixfmt.excludes = ["../nixos/packages" "../cells"];
      };
    };
  };
}
