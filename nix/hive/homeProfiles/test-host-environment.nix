{
  config,
  lib,
  pkgs,
  darwinConfig,
  nixosConfig,
  osConfig,
  ...
} @ moduleArgs: let
  inherit (pkgs.stdenv) isLinux isDarwin;
  inherit (lib.strings) hasSuffix removeSuffix toLower;
  inherit (lib.attrsets) mapAttrsToList;
  inherit (lib.lists) count;

  os-option-count-min = 4;
  os-type-exclusive-option = {
    nixosConfig = "";
    darwinConfig = "";
    systemManagerConfig = "";
    wslConfig = "";
    # TODO: option shared by all OS types?
    #osConfig = "";
    #homeManagerConfig = "";
  };
  clean-os-type = modAttr:
    toLower (
      if hasSuffix "Config"
      then (removeSuffix "Config" modAttr)
      else toLower modAttr
    );
  clean-os-type-config = modAttr: "${clean-os-type modAttr}Config";
  get-os-specific-attr = os: let
    cfgType = clean-os-type-config os;
  in
    if os-type-exclusive-option ? cfgType
    then os-type-exclusive-option.${cfgType}
    else "this-option-will-never-be-set";
  test-os-specific-attr = os-name: let
    attrname = get-os-specific-attr os-name;
    # TODO: Handle WSL
    # TODO: Handle system-manager
  in
    builtins.hasAttr (get-os-specific-attr os-name) moduleArgs.${attrname};
  #moduleArgs.${attrname} ? (get-os-specific-attr os-name);

  isManaged =
    builtins.isAttrs moduleArgs.osConfig
    && (count (mapAttrsToList moduleArgs.osConfig) > os-option-count-min);
  host-config-summary = {
    managed = isManaged;
    darwin = isManaged && test-os-specific-attr "darwin";
    nixos = isManaged && test-os-specific-attr "nixos";
    wsl = isManaged && test-os-specific-attr "wsl";
    systemManager = isManaged && test-os-specific-attr "systemManager";
  };
  #host-config-summary-package = pkgs.writeTextFile {
  #  name = "os-config-summary.json";
  #  text = builtins.toJSON host-config-summary;
  #};
in {
  #home.packages = [host-config-summary-package];
  xdg.dataFile = let
    all = {
      enable = true;
      executable = false;
      target = "os-config/summary.json";
      text = host-config-summary;
    };
    map-os = os:
      all
      // {
        target = "os-config/${os}.json";
        text = builtins.toJSON (moduleArgs."${os}Config" or {});
      };
  in {
    os-config-any = map-os "os";
    os-config-darwin = lib.mkIf isDarwin map-os "darwin";
    os-config-nixos = lib.mkIf isLinux map-os "nixos";
    os-config-systemmanager = lib.mkIf isLinux map-os "systemManager";
    os-config-wsl = lib.mkIf isLinux "map-os" "wsl";
    os-config-summary = all;
  };
}
