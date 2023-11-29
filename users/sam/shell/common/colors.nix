{ inputs
, config
, lib
, pkgs
, ...
}:
# --- Colors ---------------
# TODO: Fix home-manager setting to support XDG spec
#   See: https://github.com/nix-community/home-manager/blob/master/modules/programs/dircolors.nix#blob-path
#   - home.file.".dir_colors" -> xdg.file.dircolors
#   - programs.bash.initExtra
#   - programs.fish.shellInit
#   - programs.zsh.initExtraBeforeCompInit
{
  imports = [ ];
  programs.dircolors = {
    enable = true;
    settings = {
      # `dircolors --print-database`
      ".cmd" = "01;32"; # Executabes (bright green) ---
      ".exe" = "01;32";
      ".com" = "01;32";
      ".btm" = "01;32";
      ".bat" = "01;32";
      ".msi" = "01;32";
    };
  };

}
