# App Installation Modules for NixOS, Home-Manager, & nix-darwin

## Package Manager App Name Mapping

Goals:

1. Associate all desktop applications in `nixpkgs` with their
   equivalent names in `flatpak` and other package managers.

2. Assoicate all server packages in `nixpkgs` with their
   equivalent Docker images.

3. Create list of apps unpackaged in `nixpkgs`.

4. Abstract away package installation method.
   User specifies app they want installed, and that app will be installed.

Package Managers:

- `nixpkgs`
- `flatpak` (for desktop apps)
- `docker` (for server programs)
- programming language package managers
- cross-distro package managers

Implementation Possibilities:

- Override package's derivation with new attrs:

  - `meta.packageType = "lib|app|pkg|server|assets|other"`
  - `meta.packageChannel = "stable|lts|beta|alpha|nightly|rc|master|
  - `meta.packageNames.<packageManager> = { name = "<packageName>"; channel="stable|lts|beta|alpha|nightly|rc|master|latest"; }`
  - `meta.packageNames.flatpak = { name = "<packageName>"; appId = "<appId>"; repo = "<repoName>"; branch = "stable|beta|nightly|master|<channel>|..."; };`

- Try to infer as much information as possible from `AppStream` data.
  - See if `repology` has another method of association app/package names.

## Options

### Shared

```(nix)
let cfg = config.apps; in {
imports = [];
options = {
  global = {
    installationPreference = mkOption {
      type = listOf str;
      description = "List of installation methods in order of preference";
      default = ["nix" "flatpak" "other"];
    };
    shareUserInstalls = mkOption {
      type = bool;
      description = "Whether to elevate user installations to a single system installation when multiple users install the same app in their home environment.";
      default = false;

    };
    shareSystemInstall = mkOption {
      type = bool;
      description = "Whether to skip installing an app via a more-preferred method when app is already configured to be in environment via a less-preferred method. This avoids duplicate installations at the expense of using a less-preferred installation method for an app.";
      default = false;
      # Examples:
      # - NixOS `environment.systemPackages=[<app>]` => `home.packages=[]`, NixOS + Home `services.flatpak.packages=[]`
      # - NixOS `services.flatpak.packages=[<app>]` => `environment.systemPackages=[]`, `home.packages=[]`, & Home `services.flatpak.packages=[]`
      # - Home `home.packages=[<app>]` => Home `services.flatpak.packages=[]`
    };

    allowMultipleInstalls = mkOption {
      type = bool;
      description = "Whether to allow multiple duplicate installations of the same package. If false, less preferred installation(s) will be removed unless determined otherwise by config.";
      default = true;
    };

    nixpkgs = {
      fallbackBrokenPackages = mkOption {
        type = bool;
        description = "Whether to fallback to less-preferred installation methods when a package in `nixpkgs` sets `meta.broken = true`";
        default = true;
      };
    };

    flatpak = {
      uninstallUnspecified = mkOption {
        type = bool;
        description = "Whether to remove flatpak installations not specified declaratively in the NixOS / home-manager configuration.";
        default = false;
      };
      fallbackRuntimeEOL = mkOption {
        type = bool;
        description = "Whether to fallback to less-preferred installation methods when a flatpak app is using an end-of-life runtime.";
        default = true;
      };
    };
  };

  # Individual Apps
  <appName> = {

    installationPreference = mkOption {
      type = listOf str;
      description = "List of installation methods in order of preference. Overrides the global setting for this package.";
      default = ["nix" "flatpak" "other"];
    };

    forceInstall = mkOption {
      type = oneOf bool str;
      description = "Whether to force installation of the package. Can specify the installation method to force installing via a specific method. If `true`, app will be forcibly installed via method determined by other options. If false, the app will only be installed if declared elsewhere in configuration.";
      default = false;
    };

    # TODO: Add priority field for each package manager
    packageName = {
      nixpkgs = mkPackageOption "nixpkgs";
      flatpak = mkOption {
        type = nullOr oneOf str attrs {repoName=str; type="app"|"runtime"; appId=str; branch=str;};
        description = "Attrset with repoName, type, appId, branch, or an equivalent string in the format `<repoName>/<type|null>/<appId>/<systemType|null>/<branch>`. System type will be inferred from the system.";
      };
      # ...
    };

  };

};
```

- [ ] Extend `GermanBread/declarative-flatpak` with options:
  - `services.flatpak.removeUndeclared = true | false`
  - `services.flatpak.removeUnusedRuntimes = true | false`

### Home-Manager

- `services.flatpak.shareInstalls = true`

### NixOS / nix-darwin
