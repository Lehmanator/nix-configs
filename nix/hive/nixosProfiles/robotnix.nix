{
  inputs,
  config,
  lib,
  ...
}: {
  imports = [inputs.robotnix.nixosModules.attestation-server];

  services.attestation-server = {
    enable = lib.mkDefault false;
    domain = lib.mkDefault "attestation.${config.networking.fqdn}";
    device = lib.mkDefault "cheetah";
    listenHost = lib.mkDefault "127.0.0.1";
    port = lib.mkDefault 8085;
    #signatureFingerprint = config.sops.secrets.attestation-signature-fingerprint.path; # TODO: Use text
    #avbFingerprint = config.sops.secrets.attestation-avb-fingerprint.path; #           # TODO: Use text
    disableAccountCreation = lib.mkDefault false;
    email = {
      #username = lib.mkDefault config.sops.secrets.email-dev-coverall-account.path;
      passwordFile =
        lib.mkDefault config.sops.secrets.email-dev-coverall-password.path;
      port = lib.mkDefault 465;
      #host = lib.mkDefault config.sops.secrets.email-host-server.path;
      local = lib.mkDefault false;
    };
    nginx = {
      enable = lib.mkDefault true;
      enableACME = lib.mkDefault true;
    };
  };

  environment.persistence."/nix/persist".directories = ["/var/lib/private/attestation"];
  networking.firewall.allowedTCPPorts =
    lib.mkDefault [config.services.attestation-server.port];

  sops.secrets = lib.mkIf config.services.attestation-server.enable {
    attestation-signature-fingerprint = {};
    attestation-avb-fingerprint = {};
  };
}
