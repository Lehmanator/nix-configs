{ inputs, self
, config, lib, pkgs
, ...
}:
{
  imports = [
  ];

  # --- Binary Cache -------------------
  nix.settings = {
    builders-use-substitutes = true; # Allow builders to use binary caches
    substituters = [
      "https://cache.nixos.org/"
      "https://nix-community.cachix.org/"
      "https://nix-on-droid.cachix.org/"
      "https://robotnix.cachix.org/"
      "https://nrdxp.cachix.org/"
      "https://numtide.cachix.org/"
      "https://snowflakeos.cachix.org/"
      "https://cache.thalheim.io/"
      "https://lehmanator.cachix.org/"
    ];
    trusted-substituters = [
      "https://cache.nixos.org/"
      "https://hydra.nixos.org/"
      "https://nix-community.cachix.org/"
      "https://nix-on-droid.cachix.org/"
      "https://robotnix.cachix.org/"
      "https://nrdxp.cachix.org/"
      "https://numtide.cachix.org/"
      "https://snowflakeos.cachix.org/"
      "https://lehmanator.cachix.org/"
    ];
    # TODO: Get public keys for missing caches
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "hydra.nixos.org-1:CNHJZBh9K4tP3EKF6FkkgeVYsS3ohTl+oS0Qa8bezVs="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "nix-on-droid.cachix.org-1:56snoMJTXmDRC1Ei24CmKoUqvHJ9XCp+nidK7qkMQrU="
      "nrdxp.cachix.org-1:Fc5PSqY2Jm1TrWfm88l6cvGWwz3s93c6IOifQWnhNW4="
      "numtide.cachix.org-1:2ps1kLBUWjxIneOy1Ik6cQjb41X0iXVXeHigGmycPPE="
      "snowflakeos.cachix.org-1:gXb32BL86r9bw1kBiw9AJuIkqN49xBvPd1ZW8YlqO70="
      "cache.thalheim.io-1:R7msbosLEZKrxk/lKxf9BTjOOH7Ax3H0Qj0/6wiHOgc="
      "lehmanator.cachix.org-1:kT+TO3tnSoz+lxk2YZSsMOtVRZ7Gc57jaKWL57ox1wU="
    ];
  };

}
