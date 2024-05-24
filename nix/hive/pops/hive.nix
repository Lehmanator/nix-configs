{ inputs, cell, }@commonArgs:
# TODO: Add inputs used in NixOS, nix-darwin, wsl, home-manager
# TODO: call cell.pops.hive.setHosts in ../nixosConfigurations.nix ???
inputs.omnibus.pops.hive.setHosts cell.pops.hosts.exports.default
