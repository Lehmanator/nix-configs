{
  accept-flake-config = true;
  experimental-features = [
    "nix-command"
    "flakes"
  ];

  #plugin-files = [
  #  "${pkgs.nix-doc}/lib/libnix_doc_plugin.so"
  #  "${pkgs.nix-plugins}/lib/nix/plugins/libnix-extra-builtins.so"
  #];

}
