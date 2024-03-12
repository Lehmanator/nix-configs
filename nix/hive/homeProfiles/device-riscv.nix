{ inputs
, config, lib, pkgs
, ...
}:
{
  imports = [
  ];

  home.packages = [
    pkgs.nur.repos.uniquepointer.riscv64-linux-gnu-toolchain
    pkgs.nur.repos.YisuiMilena.devtools-riscv64
  ];
}
