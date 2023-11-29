{ inputs, config, lib, pkgs, ... }:
{
  imports = [ ../common ];
  home.packages = [ inputs.nur.repos.federicoschonborn.gradebook ];
}
