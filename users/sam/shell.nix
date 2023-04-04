{
  self,
  inputs,
  system,
  hosts, userPrimary,
  config, lib, pkgs,
  ...
}:
let
in
{
  imports = [
    ./shell-alias.nix
  ];

  programs.bash.enableVteIntegration = true;
  programs.bash.historyControl = [ "ignorespace" ];


  # --- Direnv ----------------
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  # --- Directory Listing -----
  programs.exa.enable = true;
  programs.exa.enableAliases = true;
  programs.exa.git = false;
  programs.exa.icons = true;
  programs.exa.extraOptions = [
    #"--header"
    "--group-directories-first"
  ];

  # --- Colors ---------------
  programs.dircolors.enable = true;
  programs.dircolors.settings = {  # `dircolors --print-database`
    ".cmd" = "01;32"; # Executabes (bright green) ---
    ".exe" = "01;32";
    ".com" = "01;32";
    ".btm" = "01;32";
    ".bat" = "01;32";
    ".msi" = "01;32";
  };

  home.packages = [
    pkgs.figlet               # Print ASCII art text
    pkgs.nix-zsh-completions  # Completions for Nix, NixOS, NixOps, & ecosystem
    pkgs.with-shell           # Interactive shell where each command starts with cmd prefix
    pkgs.zsh-nix-shell        # ZSH plugin that lets you use ZSH in nix-shell
  ];
}
