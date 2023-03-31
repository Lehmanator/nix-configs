{
  self,
  system,
  host, userPrimary,
  inputs,
  config, lib, pkgs,
  ...
}:
{
  nix.gc.automatic = true;
  nix.settings = {
    allowed-users = [ "*" ];
    connect-timeout = lib.mkDefault 10;
    log-lines = 25;
    min-free = 128000000;
    max-free = 1000000000;
    experimental-features = [ "nix-command" "flakes" ];
    fallback = true;
    warn-dirty = false;
    auto-optimise-store = true;
    sandbox = true;

    substituters = [
      "https://cache.nixos.org/"
      "https://snowflakeos.cachix.org/"
    ];
    trusted-substituters = [
      "https://hydra.nixos.org/"
      "https://snowflakeos.cachix.org/"
    ];
    #trusted-public-keys = [
    #];
    trusted-users = [
      "root"
      "@wheel"
      "sam"
    ];
  };

  nixpkgs.overlays = [ 
    inputs.nur.overlay
    (final: prev: { gnome-decoder = prev.gnome-decoder.overrideAttrs (attrs: {
      preBuild = ''
        export BINDGEN_EXTRA_CLANG_ARGS="$BINDGEN_EXTRA_CLANG_ARGS -DPW_ENABLE_DEPRECATED"
      '';
      meta.broken = false;
    }); })
  ];

  nixpkgs.config.allowBroken = false;
  nixpkgs.config.allowUnfree = true;
  environment.sessionVariables.NIXPKGS_ALLOW_UNFREE = "1";
  environment.systemPackages = [ pkgs.nix-output-monitor ];

  programs.nix-index.enable = true;
  programs.nix-index.enableZshIntegration = true; # lib.mkIf config.programs.zsh.enable true;
  programs.nix-ld.enable = true;

}
