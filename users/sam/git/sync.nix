{ inputs, self
, config, lib, pkgs
, ...
}:
{
  imports = [
  ];
  services.git-sync.enable = true;
}
