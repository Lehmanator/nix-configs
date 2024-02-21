{
  inputs,
  self,
  ...
}: {
  imports = [inputs.pre-commit-hooks-nix.flakeModule];
  perSystem = {
    config,
    lib,
    pkgs,
    ...
  }: {
    pre-commit = {
      check.enable = true;
      #devShell = null;
      settings.hooks = {
        # TODO: deadnix, mdl, mkdocs, nixfmt, nixpkgs-fmt, yamllint
        actionlint = {
          enable = true;
          description = "GitHub Actions";
          #files = ".github/*.ya?ml$";
        };
      };
    };
  };
}
