{ self, inputs, config, lib, pkgs, host, network, repo,
  system ? "x86_64",
  ...
}:
{
  inputs = [
  ];
  environment.systemPackages = [
    pkgs.azure-cli
    pkgs.kubelogin
  ];
}
