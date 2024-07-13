#{inputs, cell}@cellArgs:
{ lib, ...}@cellArgs: 
let
  # inherit (inputs.nixpkgs) lib;

  pluralize = s: s + "s";
  pluralizeAll = lst: builtins.map pluralize;
  capitalizeWord = s: (lib.strings.head s) + (lib.strings.tail s);
  units = ["configuration" "profile" "module" "suite"];
  units-single = builtins.map (s: (capitalizeWord s));
  units-plural = builtins.map (s: pluralize (capitalizeWord s));
  units-all = units-single ++ units-plural;

  # mkUnits = lib.attrsets.concatMapAttrs (n: unit: lib.foldAttrs (item: acc: acc // ) {
  #   "${n}${capitalizeWord unit}"             = "${class-prefix-units.${n}}${pluralize (capitalizeWord unit)}";
  #   "${n}${pluralize (capitalizeWord unit)}" = "${class-prefix-units.${n}}${pluralize (capitalizeWord unit)}";
  # });
  # mkUnitAttrs = t: lib.attrsets.concatMapAttrs (n: unit: lib.foldAttrs (item: acc: acc // ) {
  #   "${n}${capitalizeWord unit}"             = "${class-prefix-units.${n}}${pluralize (capitalizeWord unit)}";
  #   "${n}${pluralize (capitalizeWord unit)}" = "${class-prefix-units.${n}}${pluralize (capitalizeWord unit)}";
  # });
  mkAttr = t: u: class-prefix-units.${t} + (pluralize (capitalizeWord u));
  mkClassAttrs = lib.attrsets.concatMapAttrs (name: value: {
    "${name}Configuration"  = value + "Configurations";
    "${name}Configurations" = value + "Configurations";
    "${name}Module"  = value + "Modules";
    "${name}Modules" = value + "Modules";
    "${name}Profile"  = value + "Profiles";
    "${name}Profiles" = value + "Profiles";
    "${name}Suite"  = value + "Suites";
    "${name}Suite" = value + "Suites";
  }) class-prefix-units;

  # Map common non-standard flake output attrs that correspond
  # to our units to the single, most-common attr name.
  # TODO: Consider using flake-schemas?
  class-prefix-units = rec {
    darwin = "darwin";
    nix-darwin = darwin;
    nixDarwin = darwin;

    devShell = "devShell";
    devshell = devShell;
    shell = devShell;

    eval = "eval";
    
    flake = "flake";
    flakeParts = flake;
    flake-parts = flake;

    homeManager = "homeManager";
    home-manager = homeManager;
    home = homeManager;
    hm = homeManager;

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
  inputAttrsOther = ["overlay"];
in
{
  
}
