{ self, super, root, inputs, cell, ... }@args:
#builtins.trace ([ "TEST-META" ] ++ (builtins.attrNames args))
{
  myargs = args;
  system = "x86_64-linux";
  specialArgs = { user = "sam"; };

  # Colmena args: meta
  # Args: allowApplyAll, description, machinesFile, name, nixpkgs, nodeNixpkgs, nodeSpecialArgs, specialArgs,
  colmena = {
    description = "Lehmanator's Hive";
    allowApplyAll = true;
    nixpkgs = { system = "x86_64-linux"; }; # Is this `nixpkgs.config`?
  };
  colmenaConfiguration = {
    inherit (super.nixosConfiguration) bee imports;
    deployment = {
      allowLocalDeployment = true;
      buildOnTarget = false;
      tags = [ "test" ];
    };
  };
}
