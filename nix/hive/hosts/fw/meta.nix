{ inputs, cell, self, }: {
  system = "x86_64-linux";
  stateVersion = "24.05";
  colmena = {
    nixpkgs = { }; # Is this `nixpkgs.config`?
  };
}
