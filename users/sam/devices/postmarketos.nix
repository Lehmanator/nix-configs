{ inputs, self
, config, lib, pkgs
, ...
}:
{
  imports = [
  ];

  home.packages = [ pkgs.pmbootstrap ];

}
