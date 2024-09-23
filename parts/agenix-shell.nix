{ inputs
# , config
, ...
}:
# let 
#   flakeConfig = config.flake;
# in
{
  imports = [
    inputs.agenix-shell.flakeModules.default # https://github.com/aciceri/agenix-shell
    inputs.agenix-rekey.flakeModule          # https://github.com/oddlama/agenix-rekey
  ];
  # config._module.args.pkgs = import inputs.nixpkgs {
  # };

  # Template: https://github.com/aciceri/agenix-shell/blob/master/templates/basic/flake.nix
  agenix-shell = {
    # flakeName = "nix-configs";                                 # Default: "git rev-parse --show-toplevel | xargs basename";
    identityPaths = ["$HOME/.ssh/id_rsa" "$HOME/.ssh/id_ed25519"];
    # secretsPath = "/run/user/$(id -u)/agenix-shell/$(${config.agenix-shell.flakeName})/$(uuidgen)";
    # secretsPath = "/run/user/$(id -u)/agenix-shell/$(git rev-parse --show-toplevel | xargs basename)";
    secrets = {
    #  <name> = {
    #    file = "secrets/<name>.age";                          # Age file the secret is loaded from
    #    mode = "0400";                                        # Perms mode of the decrypted secret in chmod format
    #    namePath = "<name>_PATH";                             # Variable name containing path to secret
    #    name = "<name>";                                      # Variable name containing secret
    #    path = "${config.agenix-shell.secretsPath}/<name>";   # Path where the decrypted secret is installed.
    #  };
    };
  };

  # agenix-rekey apps specific to your flake.
  #   Used by the agenix wrapper script
  #   Can be run manually using: `nix run .#agenix-rekey.$system.<app>`
  # flake.agenix-rekey = { };

  perSystem = { inputs', config, lib, pkgs, system, ... }: {
    # Agenix extension to avoid `secrets.nix` file by auto re-encrypting secrets where needed.
    #   Allows you to define versatile generators for secrets, so they can be bootstrapped automatically.
    #   This can be used alongside regular use of agenix.
    agenix-rekey = {
      agePackage = config.agenix-shell.agePackage;
      # Example: Colmena
      # inherit ((colmena.lib.makeHive self.colmena).introspect (x: x)) nodes;
      # inherit (inputs.self.colmenaHive.introspect (x: x)) nodes;
      nodes = inputs.self.nixosConfigurations;
      # inherit pkgs;
      # pkgs = import inputs.nixpkgs {
      #   inherit system;
      #   config = { allowUnfree = true; allowUnsupportedSystem=true; allowBroken=true; };
      #   overlays = [];
      # };
    };

    agenix-shell = {
      agePackage = pkgs.rage;
      # installationScript = inputs.agenix-shell.packages.${system}.installationScript.override {
      #  agenixShellConfig.secrets = { foo.file = ./secrets/foo.age; };
      # };
    };

    devshells.nixos = {
      devshell = {
        packagesFrom = [
          config.agenix-rekey.package
        ];
        startup.agenix-installation = {
          deps = [];
          text = ''
            echo 'Installing secrets from agenix-shell...'
            ${lib.getExe config.agenix-shell.installationScript}
            echo 'Installed secrets from agenix-shell.'
          '';
        };
      };
      commands = [
        { category="agenix"; package=config.agenix-shell.installationScript; help="Install agenix secrets"; }
        { category = "agenix";
          name     = "agenix-rekey"; 
          command  = "${lib.getExe inputs'.agenix-rekey.packages.default} edit";
          # help     = config.apps.agenix-edit.meta.description;
          # package  = flakeConfig.agenix-rekey.${system}.edit;
        }
        # { name     = "agenix-generate"; 
        #   help     = inputs.self.apps.${system}.agenix-generate.meta.description;
        #   package  = inputs.self.apps.${system}.agenix-generate.program;
        #   category = "secrets";
        # }
        # { name     = "agenix-rekey"; 
        #   help     = inputs.self.apps.${system}.agenix-rekey.meta.description;
        #   package  = inputs.self.apps.${system}.agenix-rekey.program;
        #   category = "secrets";
        # }
      ];
    };
    # apps = with flakeConfig.agenix-rekey.${pkgs.stdenv.system}; {
    #   agenix-edit     = { type="app"; program=edit;     meta.description="Edit your agenix secrets";             };
    #   agenix-generate = { type="app"; program=generate; meta.description="Generate your missing agenix secrets"; };
    #   agenix-rekey    = { type="app"; program=rekey;    meta.description="Rekey your existing agenix secrets";   };
    # };
  };

}
