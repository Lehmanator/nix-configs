# Repo: NixOS/nixpkgs
# Path: 
# - pkgs/desktops/gnome
#   - find-latest-version.py
# - pkgs/desktops/gnome/extensions
#   File:
#   - buildGnomeExtension.nix - uuid,pname,name,description,link,shell_version_map -> ?
#   - collisions.json
#   - default.nix
#   - extensionRenames.nix    - "<ID>@<URI>" = "<pname>"; ...
#   - extensions.json         - [{"uuid"="",name="",shell_versions_map=[{"44"={sha256=""}}]}]
#   - manuallyPackaged.nix    - {callPackage}:{pname = callPackage ./<pname>.nix {};}
#   - update-extensions.py
final: prev: rec {
  # TODO: Example converting metadata.json
  # TODO: Example using Git repo
  gnomeExtensions = prev.gnomeExtensions.overrideScope' (gfinal: gprev: {

    "<PackageName>" = lib.buildGnomeExtension {
      uuid = "<ID>@<URI>";
      name = "<ExtensionFullName>";
      pname = "<PackageName>";
      description = "<Description>";
      link = "<GnomeExtensionsURL>|<GitRepo>";
      shell_version_map = {
        "44" = { version = "<ExtVersion>"; sha256 = "HashSHA256"; };
        "43" = { version = "<ExtVersion>"; sha256 = "HashSHA256"; };
      };
    };



  });
  gnome43Extensions = mapUuidNames (produceExtensionsList "43");
  gnome44Extensions = mapUuidNames (produceExtensionsList "44");
  gnomeExtensions = lib.recurseIntoAttrs (
    (mapReadableNames (produceExtensionsList "44"))
    // (callPackage ./manuallyPackaged.nix {})
    // lib.optionalAttrs (config.allowAliases or false) {
      "<PackageName>" = gnomeExtensions."<ExistingPackageName>";
      # ...
    }
  );
  #gnomeExtensions = let
  #  buildShellExtension = callPackage prev.buildGnomeExtension { };
  #  extensionsIndex = lib.importJSON ./extensions.json;
  #  extensionRenames = import ./extensionRenames.nix;
  #  pro
  #lib.attrsets.recursiveUpdate prev.gnomeExtensions 
}
