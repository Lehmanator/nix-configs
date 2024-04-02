{ inputs, ... }: {
  std.harvest = {
    devShells = [ [ "pops" "shells" ] ];
    packages = [ [ "pops" "packages" ] ];
  };
  std.pick = {
    # --- Omnibus mkBlocks Built-in ---
    configs = [ [ "pops" "configs" ] ];
    containers = [ [ "pops" "containers" ] ];
    data-pops = [ [ "pops" "data" ] ];
    devshellProfiles = [ [ "pops" "devshellProfiles" ] ];
    homeModules = [ [ "pops" "homeModules" ] ];
    homeProfiles = [ [ "pops" "homeProfiles" ] ];
    jupyenv = [ [ "pops" "jupyenv" ] ];
    lib = [ [ "pops" "lib" ] ];
    nixago = [ [ "pops" "nixago" ] ];
    nixosModules = [ [ "pops" "nixosModules" ] ];
    nixosProfiles = [ [ "pops" "nixosProfiles" ] ];
    pops-pops = [ [ "pops" "pops" ] ];
    scripts = [ [ "pops" "scripts" ] ];
    tasks = [ [ "pops" "tasks" ] ];

    # --- Omnibus Pops ---
    allData = [ [ "pops" "allData" ] ];
    darwinModules = [ [ "pops" "darwinModules" ] ];
    darwinProfiles = [ [ "pops" "darwinProfiles" ] ];
    devshellModules = [ [ "pops" "devshellModules" ] ];
    examples = [ [ "pops" "examples" ] ];
    flakes = [ [ "pops" "flake" ] ];
    flake-parts = [ [ "pops" "flake-parts" ] ];
    hive = [ [ "pops" "hive" ] ];
    load = [ [ "pops" "load" ] ];
    microvms = [ [ "pops" "microvms" ] ];
    overlays = [ [ "pops" "overlays" ] ];
    self-pops = [ [ "pops" "self" ] ];
    srvos = [ [ "pops" "srvos" ] ];
    std = [ [ "pops" "std" ] ];
    systemManagerProfiles = [ [ "pops" "systemManagerProfiles" ] ];

    # --- Hive ---
    colmenaConfigurations = [ [ "pops" "colmenaConfigurations" ] ];
    darwinConfigurations = [ [ "pops" "darwinConfigurations" ] ];
    diskoConfigurations = [ [ "pops" "diskoConfigurations" ] ];
    homeConfigurations = [ [ "pops" "homeConfigurations" ] ];
    nixosConfigurations = [ [ "pops" "nixosConfigurations" ] ];
    # --- Custom ---
    homeSuites = [ [ "pops" "homeSuites" ] ];
    devshellSuites = [ [ "pops" "devshellSuites" ] ];
    darwinSuites = [ [ "pops" "darwinSuites" ] ];
    diskoSuites = [ [ "pops" "diskoSuites" ] ];
    nixosSuites = [ [ "pops" "nixosSuites" ] ];
    systemManagerModules = [ [ "pops" "systemManagerModules" ] ];
    systemManagerSuites = [ [ "pops" "systemManagerSuites" ] ];
  };
}
