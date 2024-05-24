{ inputs, cell, }:
inputs.omnibus.pops.nixosProfiles.addLoadExtender {
  load = {
    src = ../nixos/suites;
    type = "nixosProfilesOmnibus";
  };
}
