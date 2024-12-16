{ config, lib, pkgs, ... }:
{
  programs.zed-editor = {
    enable = true;

    # https://github.com/zed-industries/extensions/tree/main/extensions
    extensions = [
      "base16"
      "dockerfile"
      "docker-compose"
      "env"
      "helm"
      "jsonnet"
      "make"
      "typst"
    ] ++ lib.optional (builtins.elem pkgs.blueprint-compiler config.home.packages) "blueprint" #"meson"
      ++ lib.optional config.programs.nushell.enable "nu"
      ++ lib.optional config.programs.navi.enable "navi"
      ++ lib.optionals config.programs.gnome-shell.enable ["adwaita-pastel" "zedwaita"]
    ;

    # NOTE: Only in nixpkgs-unstable
    # TODO: Rust toolchains
    # extraPackages = [
    # ] ++ lib.optional (builtins.elem pkgs.blueprint-compiler config.home.packages) pkgs.blueprint-compiler
    # ;

    package = pkgs.zed-editor;

    # keymap.json (type = JSON value)
    userKeymaps = {
    };

    # settings.json (type = JSON value)
    userSettings = {
    };
  };
}
