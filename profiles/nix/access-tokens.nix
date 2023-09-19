{ inputs, self
, config, lib, pkgs
, ...
}:
{
  imports = [
  ];

  # TODO: Make secret via agenix / sops-nix
  # TODO: Replace after making secret
  nix.settings.access-tokens = [
    #"github.com=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"  # Expired: Jun 6, 2023
    "github.com=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"   # Expires: Dec 7, 2023
  ];

}
