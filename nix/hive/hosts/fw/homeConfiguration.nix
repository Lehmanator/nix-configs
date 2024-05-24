{ inputs, cell, super, }: {
  inherit (super) bee;
  home = rec {
    inherit (super.meta) stateVersion;
    username = "sam";
    homeDirectory = "/home/${username}";
  };
  imports = with inputs; [
    { _module.args = super.specialArgs; }
    nix-flatpak.homeManagerModules.nix-flatpak
  ];
}
