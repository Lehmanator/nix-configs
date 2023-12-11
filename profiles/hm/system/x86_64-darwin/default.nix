{ inputs
, config
, lib
, pkgs
, osConfig
, user
, ...
}:
{
  imports = [
    ../../arch/x86_64
    ../../platform/darwin
  ];

}
