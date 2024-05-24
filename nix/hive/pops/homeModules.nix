{inputs, cell,}@commonArgs:
{
  src = ../hm/modules;
  #inputs = commonArgs // {
  #  inputs = inputs // inputs.omnibus.lib.omnibus.loaderInputs;
  #  user = "sam";
  #};
}
