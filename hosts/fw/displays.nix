{ self, inputs, config, lib, pkgs,
  host, network, repo,
  ...
}:
{
  services.autorandr.enable = true;
  #services.autorandr.profiles.default = {
  #};
  #services.autorandr.profiles.docked = {
  #};
}
