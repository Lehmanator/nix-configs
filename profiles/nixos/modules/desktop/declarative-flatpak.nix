{ inputs
, lib
, pkgs
, user
, ...
}:
{
  imports = [ inputs.declarative-flatpak.nixosModules.declarative-flatpak ];

  services.flatpak = {
    enable = lib.mkDefault true;
    packages = lib.mkDefault [
    ];
    overrides = {
      global.filesystems = lib.mkDefault [
        "xdg-config:gtk-4.0:ro"
        "xdg-config:gtk-3.0:ro"
        "xdg-config:gtk-2.0:ro"
      ];
    };
  };

  home-manager.sharedModules = [
    inputs.declarative-flatpak.homeManagerModules.declarative-flatpak
    # --- OR ---
    #../../../hm/profiles/modules/declarative-flatpak.nix
  ];
}
