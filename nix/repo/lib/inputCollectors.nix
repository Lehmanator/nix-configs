{ inputs, cell,}@cellArgs:  # - homeManagerModule

# Goals:
#
# - Collect certain flake outputs from all inputs into single attrset.
# - Allow importing all nixosModules, etc. from all flakes
# - Allow importing all overlays from all flakes
#
# Problems:
#
# - Flake output attrs are named inconsistently between flakes.
#   Examples:
#   - `overlays.default` vs `overlay`
#   - `overlays.<inputName>` vs `overlays.default` (implies overlays.default?)
#   - `hmModules.<inputName>` vs. `nixosModules.home-manager` (implies hmModulee?)
# - Flakes may provide the same item under multiple attrNames.
# - Some items may be extension/collection of others.
#   Examples:
#   - nixos-generators.nixosModules.all-formats & nixos-generators.nixosModules.<format> 
# - Flake <inputName> may differ from `<inputName>.nixosModules.<inputName2>`
# - How can we tell which attrName should be default when flakes doesnt provide `<output>.default`
#
# Cases to handle:
#
# - <name>.nixosModules.default + <name>.nixosModule + `<name>.nixosModules.<name>`
# - <name>.nixosModules.home-manager (implies module is for hm)
#
let
  inherit (inputs.nixpkgs) lib;
  l = lib // builtins;

  # --- Data ---
  # List of config unit types
  units = ["configuration" "profile" "module" "suite"];

  # Mapping for common non-standard flake output attrs:
  #  from: commonly used alternative attr names
  #    to: most-commonly used attr name
  # TODO: Consider using flake-schemas?
  class-prefix-units = rec {
    darwin = "darwin";
    nix-darwin = darwin;
    nixDarwin = darwin;

    devshell = "devshell";
    # devShell = devshell;
    shell = devshell;

    eval = "eval";
    
    flake = "flake";
    flakeParts = flake;
    flake-parts = flake;

    homeManager = "homeManager";
    home-manager = homeManager;
    home = homeManager;
    hm = homeManager;

    liminix = "liminix";

    nixOnDroid = "nixOnDroid";
    nix-on-droid = nixOnDroid;
    nixDroid = nixOnDroid;
    
    nixos = "nixos";
    
    nixvim = "nixvim";
    neovim = nixvim;
    vim = nixvim;
    
    robotnix = "robotnix";
    
    systemManager = "systemManager";
    system-manager = systemManager;

    wsl = "wsl";
  };

  # --- Helper Functions ---
  # pluralize = s: if (l.hasSuffix "s") then s else s + "s";
  # pluralizeAll = lst: builtins.map pluralize;
  # capitalizeWord = s: (lib.strings.head s) + (lib.strings.tail s);
  # units-single = builtins.map (s: (capitalizeWord s));
  # units-plural = builtins.map (s: pluralize (capitalizeWord s));
  # units-all = units-single ++ units-plural;
  # mkAttr = t: u: class-prefix-units.${t} + (pluralize (capitalizeWord u));
  # mkUnits = lib.attrsets.concatMapAttrs (n: unit: lib.foldAttrs (item: acc: acc // ) {
  #   "${n}${capitalizeWord unit}"             = "${class-prefix-units.${n}}${pluralize (capitalizeWord unit)}";
  #   "${n}${pluralize (capitalizeWord unit)}" = "${class-prefix-units.${n}}${pluralize (capitalizeWord unit)}";
  # });
  # mkUnitAttrs = t: lib.attrsets.concatMapAttrs (n: unit: lib.foldAttrs (item: acc: acc // ) {
  #   "${n}${capitalizeWord unit}"             = "${class-prefix-units.${n}}${pluralize (capitalizeWord unit)}";
  #   "${n}${pluralize (capitalizeWord unit)}" = "${class-prefix-units.${n}}${pluralize (capitalizeWord unit)}";
  # });

  # --- Export Functions ---
  mkClassAttrs = (lib.attrsets.concatMapAttrs (name: value: {
    "${name}Configuration"  = value + "Configurations";
    "${name}Configurations" = value + "Configurations";
    "${name}Module"  = value + "Modules";
    "${name}Modules" = value + "Modules";
    "${name}Profile"  = value + "Profiles";
    "${name}Profiles" = value + "Profiles";
    "${name}Suite"  = value + "Suites";
    "${name}Suites" = value + "Suites";
  }) class-prefix-units) // {

    # Manual overrides for flake attrs not following this pattern.
    devShells = "devShells";
    devshellConfiguration = "devShells";
    devshellConfigurations = "devShells";
    overlay = "overlays";
    overlays = "overlays";
  };

  # TODO: Map `<attr>` to `<attr>s.default` if `<attrs>.default` doesnt exist
in
{
  inherit mkClassAttrs;
}
