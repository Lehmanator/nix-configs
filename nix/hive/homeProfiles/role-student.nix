{ inputs, config, lib, pkgs, ... }:
{
  home.packages = [ inputs.nur.repos.federicoschonborn.gradebook ];
}
