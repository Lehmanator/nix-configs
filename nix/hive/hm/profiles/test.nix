{ config, lib, pkgs, osConfig, inputs, cell, ... }@moduleArgs:
let
  isStandaloneHM = !(builtins.hasAttr "osConfig" moduleArgs)
    && (moduleArgs.osConfig != { });
  isNixOS = !isStandaloneHM;
in
{
  imports = with cell.homeProfiles;
    [ desktop-common ] ++ lib.optional pkgs.stdenv.isX86_64 desktop-x86_64
    ++ lib.optional pkgs.stdenv.isAarch64 desktop-aarch64
    ++ lib.optional isStandaloneHM desktop-unmanaged
    ++ lib.optional (!isStandaloneHM) desktop-managed;
}
