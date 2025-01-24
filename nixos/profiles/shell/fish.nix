{
  config,
  lib,
  pkgs,
  ...
}: {
  environment.pathsToLink = ["/share/fish"];
}
