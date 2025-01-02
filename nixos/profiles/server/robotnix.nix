{ inputs, config, lib, pkgs, ... }:
let
  inherit (lib) mkDefault mkIf;
in
{
  # https://github.com/nix-community/robotnix
  imports = [ inputs.robotnix.nixosModules.attestation-server ];

  services.attestation-server = {
    enable = mkDefault false;
    domain = mkDefault "attestation.${config.networking.fqdn}";
    device = mkDefault "cheetah";
    listenHost = mkDefault "127.0.0.1";
    port = mkDefault 8085;
    #signatureFingerprint = config.sops.secrets.attestation-signature-fingerprint.path; # TODO: Use text
    #avbFingerprint = config.sops.secrets.attestation-avb-fingerprint.path; #           # TODO: Use text
    disableAccountCreation = mkDefault false;
    email = {
      #username = mkDefault config.sops.secrets.email-dev-coverall-account.path;
      passwordFile = mkDefault config.sops.secrets.email-dev-coverall-password.path;
      port = mkDefault 465;
      #host = mkDefault config.sops.secrets.email-host-server.path;
      local = mkDefault false;
    };
    nginx = {
      enable = mkDefault true;
      enableACME = mkDefault true;
    };
  };

  # Persist data directories
  environment.persistence."/nix/persist".directories = ["/var/lib/private/attestation"];

  # Allow through firewall
  networking.firewall.allowedTCPPorts = mkDefault [config.services.attestation-server.port];

  # Store secrets for attestation signatures
  sops.secrets = mkIf config.services.attestation-server.enable {
    attestation-signature-fingerprint = { };
    attestation-avb-fingerprint = { };
  };
}
