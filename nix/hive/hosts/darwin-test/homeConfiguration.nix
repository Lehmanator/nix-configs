{ inputs, cell, super, }: {
  inherit (super.meta.darwinConfiguration) bee;
  home = rec {
    stateVersion = "24.05";
    username = "sam";
    homeDirectory = "/home/${username}";
  };
}
