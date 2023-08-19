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
    "github.com=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"
  ];

}
