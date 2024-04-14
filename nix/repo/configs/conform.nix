{
  inputs,
  cell,
}: let
  l = inputs.nixpkgs.lib // builtins;
  mkConfigTypeBlockList = cfgType:
    builtins.map (subt: cfgType + subt) [
      "Configurations"
      "Modules"
      "Profiles"
      "Suites"
    ];
  mkConfigTypesBlockList =
    inputs.dmerge.append builtins.map mkConfigTypeBlockList;
in
  {
    meta = rec {
      homepage = "https://github.com/siderolabs/conform";
      description = "siderolabs/conform: Tool to enforce policies on your commits.";
      longDescription = ''
        **${description}**

        Used for Conventional Commits.

        repository: `${homepage}`
        blockType: `nixago`
      '';
    };
  }
  // (inputs.std.lib.dev.mkNixago inputs.std.data.configs.conform {
    # TODO: Find all options.
    data = {
      # TODO: What does this do?
      inherit (inputs) cells;

      # TODO: Get scopes from blockTypes
      #commit.conventional.scopes =
      #  (mkConfigTypesBlockList [
      #    "arion"
      #    "darwin"
      #    "devshell"
      #    "disko"
      #    "hardware"
      #    "home"
      #    "nixOnDroid"
      #    "nixos"
      #    "nixvim"
      #    "robotnix"
      #    "wsl"
      #  ])
      #  ++ [".*."];
      commit.conventional.scopes = inputs.dmerge.append [
        "nixosConfigurations"
        "nixosModules"
        "nixosProfiles"
        "homeConfigurations"
        "homeProfiles"
        "homeModules"
        "darwinConfigurations"
        "darwinModules"
        "darwinProfiles"
        "devshellConfigurations"
        "devshellModules"
        "devshellProfiles"
        "devshellSuites"
        "diskoConfigurations"
        "diskoModules"
        "diskoProfiles"
        "diskoSuites"
        ".*."
      ];
    };
  })
