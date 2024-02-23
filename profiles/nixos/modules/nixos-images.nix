{inputs, ...}: {
  # TODO: Probably cant use all of these at once
  # TODO: Probably cant use in live system
  imports = with inputs.nixos-images.nixosModules; [
    kexec-installer
    netboot-installer
    noninteractive
  ];

  #environment.persistence."/nix/persist".directories = lib.mkIf config.services.invokeai.enable [ "/var/lib/invokeai" ];
}
