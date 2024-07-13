{ config, lib, pkgs , ... }: {
  home.packages = [
    pkgs.coreboot-toolchain.riscv
    # pkgs.nur.repos.uniquepointer.riscv64-linux-gnu-toolchain # Insecure: 2024-06-03
    # pkgs.nur.repos.YisuiMilena.devtools-riscv64
  ];
}
