{ inputs, cell, }@commonArgs:
inputs.omnibus.pops.homeProfiles.addLoadExtender {
  load = {
    src = ../userProfiles;
    type = "nixosProfilesOmnibus";
    inputs = commonArgs // {
      #user = "sam";
      #inherit inputs cell;
    };
    #transformer = inputs.haumea.lib.transformers.liftDefault;
  };
}
