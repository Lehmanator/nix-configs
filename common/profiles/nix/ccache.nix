{ config, pkgs, user, ... }:
let
  ccache-config-norepro = ''
    # WARNING: May break reproducibility
    # See: https://github.com/NixOS/nixpkgs/issues/109033
    # See: https://wiki.nixos.org/wiki/CCache
    export CCACHE_SLOPPINESS=random_seed
    export CCACHE_NOHASHDIR=true
    export CCACHE_BASEDIR="$NIX_BUILD_TOP"
  '';

  ccache-config = cfg: ''
   export CCACHE_COMPRESS=1
   export CCACHE_DIR="${cfg.cacheDir or "/nix/var/cache/ccache"}"
   export CCACHE_UMASK=007

   if [ ! -d "$CCACHE_DIR" ]; then
     echo "====="
     echo "Directory '$CCACHE_DIR' does not exist"
     echo "Please create it with:"
     echo "  sudo mkdir -m0770 '$CCACHE_DIR'"
     echo "  sudo chown ${cfg.owner or "root"}:${cfg.group or "nixbld"} '$CCACHE_DIR'"
     echo "====="
     exit 1
   fi
   if [ ! -w "$CCACHE_DIR" ]; then
     echo "====="
     echo "Directory '$CCACHE_DIR' is not accessible for user $(whoami)"
     echo "Please verify its access permissions"
     echo "====="
     exit 1
   fi
  '';

  ccache-create = pkgs.writeScript "ccache-create" ''
    CCACHE_DIR="/nix/var/cache/ccache"
    sudo mkdir -m0770 -p "$CCACHE_DIR"

    # Linux
    sudo chown --reference=/nix/store "$CCACHE_DIR"

    # MacOS workaround for chown --reference
    nix-shell -p coreutils --run 'sudo chown --reference=/nix/store "$CCACHE_DIR"'
  '';

  hmConfig = { osConfig, ... }: {
   # non-NixOS systems only: (only relevant portion of this config)
    nixpkgs.overlays = [(self: super: {
      ccacheWrapper = super.ccacheWrapper.override { 
        extraConfig = (ccache-config osConfig.programs.ccache) + ccache-config-norepro;
      };
    })];
    home.packages = [
      ccache-create
      pkgs.ccache
      pkgs.ccacheWrapper
    ];
  };
in
{
  # See:
  # - https://wiki.nixos.org/wiki/CCache
  # - `programs.ccache` options: `<nixpkgs>/nixos/modules/programs/ccache.nix`
  #
  # Monitor with: `$ nix-ccache --show-stats`
  #
  # Usage:
  #
  #   NOTE: If package is top-level package, add to list: `programs.ccache.packageNames`
  #   programs.ccache.packageNames = ["ffmpeg"];
  #
  #   NOTE: Some packages dont use stdenv directly, so need to plumb thru other deps first. 
  #   nixpkgs.overlays = [
  #     (self: super: { ffmpeg = super.ffmpeg.override { stdenv = super.ccacheStdenv; }; })
  #   ];
  #
  #   TODO: Create other builders that use ccache (like ccacheStdenv)
  #     (self: super: { <pname> = super.<pname>.override { stdenv = super.ccacheStdenv; }; })
  #
  #   TODO: Move bulk of config to: `<self>/nixos/profiles/nix/ccache.nix` 

  programs.ccache = {
    enable = true;
    cacheDir = "/nix/var/cache/ccache";  # "/var/cache/ccache";
    packageNames = [

      # --- NixOS-Mobile ---
      #"phoc"
      "mutter-devel"      # "mutter"
      "gnome-shell-devel" # "gnome-shell"
      "linux"

      # --- GTK Apps ---
      "iplan"
      "nixos-conf-editor"
      "nix-software-center"

      # --- Misc large programs ---
      #"ffmpeg"

    ];
  };

  environment.systemPackages = [ pkgs.ccache pkgs.ccacheWrapper ];
  users.users = {
    root.extraGroups = [ "nixbld" ];
    ${user}.extraGroups = [ "nixbld" ];
  };
  nix.settings.extra-sandbox-paths = [ config.programs.ccache.cacheDir ];
  nixpkgs.overlays = [
    # NixOS systems only:
    (self: super: { 
      ccacheWrapper = super.ccacheWrapper.override {
        extraConfig = (if super.ccacheWrapper ? "extraConfig"
          then super.ccacheWrapper.extraConfig
          else ccache-config config.programs.ccache
        ) + ccache-config-norepro;
      };
    })
    # (self: super: { buildPackages = pkgs.buildPackages // { stdenv = pkgs.buildPackages.ccacheStdenv; }; })

  ];
}
