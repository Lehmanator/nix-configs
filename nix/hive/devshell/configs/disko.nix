{ inputs, cell, }:
let
  l = nixpkgs.lib // builtins;
  inherit (inputs) nixpkgs;
  inherit (inputs.std) lib std;
  inherit (inputs.disko.packages) disko disko-doc;
  #l.mapAttrs (_: lib.dev.mkShell) {
in
lib.dev.mkShell {
  # `default` is a special target in newer nix versions
  # see: harvesting below
  name = "Disko Disk Management Shell";
  # make `std` available in the numtide/devshell
  imports = [ std.devshellProfiles.default ];
  packages = [ disko disko-doc ];
  env = [{
    name = "BROWSER";
    value = "firefox";
  }]; # TODO: Remove
  commands = [
    {
      name = "disko-docs";
      category = "disko-info";
      help = "Display disko documentation";
      command = "$BROWSER ${disko-doc}/index.html";
    }
    {
      name = "disko-help";
      category = "disko-info";
      help = "Show helptext for disko command";
      command = "${disko}/bin/disko --help";
    }
    {
      name = "disko";
      category = "disko";
      help =
        "Unmount & destroy all filesystems on the disks we want to format, then run the create & mount mode";
      command = "${disko}/bin/disko --mode disko --flake";
    }
    {
      name = "disko-format";
      category = "disko";
      help = "Create partition tables, zpools, LVMs, RAIDs, & filesystems.";
      command = "${disko}/bin/disko --mode format --flake";
    }
    {
      name = "disko-mount";
      category = "disko";
      help = "Mount the partition at the specified root-mountpoint";
      command = "${disko}/bin/disko --mode mount --flake";
    }
  ];
}
