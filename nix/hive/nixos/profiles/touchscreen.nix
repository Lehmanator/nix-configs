{ config, lib, pkgs, ... }: {
  boot.kernelModules = ["hid_multitouch"];
}
