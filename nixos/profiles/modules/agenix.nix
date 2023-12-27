{ inputs, config, lib, pkgs, user, ... }:
{
  imports = [ inputs.agenix.nixosModules.age ];
  home-manager.sharedModules = [ inputs.agenix.homeManagerModules.age ]; # OR ../../../hm/profiles/modules/agenix.nix

  age = {
    ageBin = lib.mkDefault "${pkgs.age}/bin/age";  # TODO: Replace with `rage`? (rust age CLI util)
    identityPaths = lib.mkDefault [
      "/var/lib/persistent/ssh_host_ed25519_key"
      "/nix/persist/etc/ssh/ssh_host_ed25519_key"
      "/etc/ssh/ssh_host_ed25519_key"
    ];
    #secretsDir = lib.mkDefault "/run/agenix";
    #secretsMountPoint = lib.mkDefault "/run/agenix.d";
  };

  # Agenix CLI uses file `./secrets.nix` to determine keys used to encrypt data.
  #
  #  - This file is not controlled by your system's Nix config, but is read by the CLI directly.
  #      This is limiting because we cannot reference values from system configs.
  #
  #  - However, the file path used by `agenix` can be set using the `RULES` environment variable.
  #    So we can use this to dynamically adjust our `secrets.nix` file.
  #      Ideas:
  #      - Use `direnv` to set the `RULES` env var upon changing into subdirectories
  #      - Write shell script to wrap `agenix` w/ `RULES` set according to the argument file path.
  #      - Write shell script to wrap `agenix` w/ `cd` command into dir w/ the argument file path & use separate `secrets.nix` files.
  #        - `agenix() { echo $1 | cut -d '/' -f1 | xargs cd`
  #      - Import Nix configs nested deeper in the file tree.
  #
  # Set env var `RULES` to specify path to `./secrets.nix`


}
