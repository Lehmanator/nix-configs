{ inputs, cell, }@commonArgs:
inputs.omnibus.pops.nixosProfiles.addLoadExtender {
  load = {
    src = ../nixos/suites;
    type = "nixosProfilesOmnibus";
    # type = "nixosProfilesOmnibus";
    inputs = commonArgs;
  };
}
