{ inputs
, config, lib, pkgs
, ...
}:
{
  imports = [
  ];

  home.packages = [
    pkgs.nur.repos.kira-bruneau.caprine   # FB Messenger desktop client
  ];

}
