{ inputs, self
, config, lib, pkgs
, ...
}:
{
  imports = [
  ];

  nix = {
    # Use Nix package manager package with builtin flakes support
    package = lib.mkDefault pkgs.nixFlakes; #pkgs.nixFlakes; #(nixUnstable for use-xdg-base-directories, nixFlakes for flakes support)

    settings = {
      accept-flake-config = true;
      experimental-features = [ "nix-command" "flakes" "repl-flake" ];
      #use-flake-registry = true; #config.nix.settings.use-registries;
    };
  };

}
