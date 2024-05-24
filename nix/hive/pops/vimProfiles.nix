{ inputs, cell, }@commonArgs:
inputs.omnibus.pops.homeProfiles.addLoadExtender {
  load = {
    src = ../vim/profiles;
    type = "nixosProfiles";
    inputs = commonArgs;
  };
}
