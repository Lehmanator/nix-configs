{ self
, inputs
, config
, lib
, pkgs
, ...
}:
{
  imports = [
  ];

  home.packages = [
    #pkgs.nur.repos.jakobrs.joycond  # Breaks: libudev renamed to udev
    pkgs.ryujinx # Nintendo Switch   #pkgs.nur.repos.ivar.ryujinx
  ];
}
