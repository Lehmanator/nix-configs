{ inputs, lib, pkgs, ... }: {
  imports = [ inputs.envfs.nixosModules.envfs ];
  services.envfs.enable = true;

  # TODO: Figure out how to divide envfs & normalize profiles
  # https://github.com/thiagokokada/nix-alien
  # https://github.com/Lassulus/nix-autobahn
  # https://github.com/Mic92/nix-ld
  environment.systemPackages = [
    # TODO: Create packages
    (pkgs.writeShellScriptBin "python-wrapped-ld" ''
      export LD_LIBRARY_PATH=$NIX_LD_LIBRARY_PATH
      exec ${pkgs.python3}/bin/python "$@"
    '')
    (pkgs.writeShellScriptBin "node-wrapped-ld" ''
      export LD_LIBRARY_PATH=$NIX_LD_LIBRARY_PATH
      exec ${pkgs.nodePackages.nodejs}/bin/node "$@"
    '')
    (pkgs.writeShellScriptBin "npm-wrapped-ld" ''
      export LD_LIBRARY_PATH=$NIX_LD_LIBRARY_PATH
      exec ${pkgs.nodePackages.npm}/bin/npm "$@"
    '')
  ];
}
