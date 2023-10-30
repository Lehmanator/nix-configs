{
  accept-flake-config = true;
  experimental-features = [
    "nix-command"
    "flakes"
    "ca-derivations"
  ];

  #plugin-files = [
  #  "${pkgs.nix-doc}/lib/libnix_doc_plugin.so"
  #  "${pkgs.nix-plugins}/lib/nix/plugins/libnix-extra-builtins.so"
  #];

  # TODO: Make secret with agenix / sops-nix
  access-tokens = [
    #"github.com=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"
    #"github.com=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"
    "github.com=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"
    #"github.com=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"
  ];
}
