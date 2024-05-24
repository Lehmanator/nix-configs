{ self, inputs, cell, ... }@args:
#builtins.trace ([ "TEST-META" ] ++ (builtins.attrNames args))
{
  myargs = args;
  system = "aarch64-darwin";
  specialArgs = { user = "sam"; };
  colmena = {
    nixpkgs = { system = "aarch64-darwin"; }; # Is this `nixpkgs.config`?
  };
  colmenaConfiguration = {
    inherit (self.nixosConfiguration) bee imports;
    deployment = {
      allowLocalDeployment = true;
      tags = [ "test" ];
    };
  };
  darwinConfiguration = {
    system.stateVersion = 4;
    bee = {
      system = "aarch64-darwin";
      inherit (inputs) wsl;
      inherit (inputs.omnibus.flake.inputs) darwin;
      home = inputs.home-manager;
      pkgs = cell.pkgs.unstable-with-overlays;
    };
    homebrew = {
      enable = true;
      onActivation = {
        autoUpdate = true;
        upgrade = true;
      };
    };
    imports = [{ _module.args = self.specialArgs; }];
  };
}
