# `//hive/nixosModules/requests`

Allows `home-manager` users to request configuration changes from their host system.

`nixosModule` to provide method for `home-manager` users to request
changes to the system environment.

Idea is that `home-manager` users can request that the host system
set some NixOS options or makes some package available
that the user needs for some `home-manager` options to work.

## Implementation Overview

### User Requesting Process

- Write file with request details to:

  - Host-managed `home-manager`: `pkgs.writeTextFile` writes to Nix store path
  - User-managed `home-manager`: `config.xdg.dataHome."host-requests/${id}.json`

- Retrieve host response can by reading:

  - Host-managed `home-manager`: `osConfig.requests.${home.username}.${id}`
  - User-managed `home-manager`: `config.xdg.dataHome."host-requests/${id}.response.json`

- Add entry to `home-manager` news when request granted/denied.

## Nix Items

- libs to prefix home-manager option setting with.

  ```(nix)
  lib.requestHostPackage = requestHost@{
    id ? "",
    reason ? "unspecified",
    description ? "unspecified",

    hmOptionName ? "unspecified",
    hmPackages ? [],
    nixosOptionNames ? [],
    nixosPackageNames ? [],
    ...
  }: pkgList: let
    isGranted = (builtins.fromJSON config.xdg.dataHome."nixosRequests".${id}.json).response.granted;
    isDenied =  (builtins.fromJSON config.xdg.dataHome."nixosRequests".${id}.json).response.denied;
  in if isGranted then pkgList else (pkgs.write;

  lib.requestHost = { nixosRequest ? {}, ... }@hmOptionValue: let
  in hmOptionValue
  }

  # Request host when setting home-manager option value
  #  Usage: Prefix existing option assignment with call to this lib.
  lib.requestHostOption = { nixosRequest ? {}, ... }@hmOptionValue: let
  in {

  };
    #hmOption ? "home.packages", packageName ? "null", unmanagedHome ? false}: ...`

  ```

### `homeManagerModules.host-requests`

- Add `activationScripts.host-requests` that prints open & recently-closed requests w/ their details.
- Provide options: `host-requests = [{ request-details={...}; ... }]`

### `nixosModules.host-requests`

- Add `activationScripts.host-requests` that prints open user requests w/ their details.
- Provide options:

  ```(nix)
  host-requests.<user>.${id} = {
    grant = true;
    open = true;
    automatic = false;
    reason = "";
    extraReply = "";
  };
  host-requests.automatic = {
    approve = {
      packages = true;
      packageNames = true;
      optionNames = [];
      optionConditions = []; # fn: nixosOptionName -> bool
      unmanagedHome = true;
    };
    deny = {
      duration = "1y";
      rebuilds = 20;
      optionNames = [];
      packages = false;
      packageNames = [];
      packageConditions = []; # fn: packageName -> bool
      optionConditions.nixos = []; # fn: nixosOptionName -> bool
      optionConditions.home-manager = []; # fn: nixosOptionName -> bool
      unmanagedHome = false;
    };
  };
  ```

## Considerations

- Never allow users to change security sensitive options of hosts they don't have permission.
- Pollute the system as little as possible.
- Reduce friction when setting config options.
- Support CRUD-like workflow in declarative config.
- Support both host-managed & user-managed `home-manager` installations.
- Report host system causing downstream breakages.
- Handle user changing request details without spamming admin. (updated requests with new information).
