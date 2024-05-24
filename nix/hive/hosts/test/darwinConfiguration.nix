{ inputs, cell, super, ... }@args: {
  inherit (super.nixosConfiguration) bee;
  imports = [ ];
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      upgrade = true;
    };
  };
}
