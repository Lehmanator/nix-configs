{ inputs, cell, }:
{ config, lib, pkgs, ... }:
let inherit inputs cell;
in { environment.etc."testing".text = "true"; }
