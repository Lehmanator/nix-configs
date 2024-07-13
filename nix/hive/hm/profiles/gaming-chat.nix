{ cell, config, lib, pkgs, ... }:
{
  imports = [
    cell.homeProfiles.app-discord
    cell.homeProfiles.app-twitch
  ];

}
