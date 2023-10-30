{ self, inputs, config, lib, pkgs, ... }:
{
  # TODO: Make secret with agenix / sops-nix
  nix.settings.access-tokens = [
    #"github.com=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"
    #"github.com=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"
    #"github.com=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"
  ];
}
