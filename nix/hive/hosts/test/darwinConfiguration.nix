{ super, inputs, cell, ... }@args: {
  inherit (super.meta.nixosConfiguration) bee; # imports;
  imports = [ ];
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      upgrade = true;
    };
  };
}
