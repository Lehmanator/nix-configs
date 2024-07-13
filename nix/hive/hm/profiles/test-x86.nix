{ config, lib, pkgs, ... }: {
  home.file."test".text = ''
    test-x86
  '';
}
