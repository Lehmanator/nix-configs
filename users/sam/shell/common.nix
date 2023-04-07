{
  self,
  inputs,
  system,
  host, network, repo,
  userPrimary,
  config, lib, pkgs,
  ...
}:
{
  imports = [
    ./alias.nix
    ./pager.nix
  ];

  programs.bash.enableVteIntegration = true;
  programs.bash.historyControl = [ "ignorespace" ];


  # --- Direnv ----------------
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  # --- Directory Listing -----
  programs.exa = {
    enable = true;
    enableAliases = true;
    git = true;
    icons = true;
    extraOptions = [ "--group-directories-first" ]; #"--header"
  };
  home.shellAliases.l = "exa -a";

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

  # --- Prompt ---------------
  programs.starship.enable = true;

  # --- Dev Shells -----------
  services.lorri.enable = true;

  # --- Documentation --------
  manual = {
    html.enable = true;
    json.enable = true;
    manpages.enable = true;
  };
  news.display = "notify";
  programs.tealdeer = {
    enable = true;
    settings = {
      display.compact = true; 
      display.use_pager = false;
      updates.auto_update = true;
      #style.example_variable.foreground = "cyan";
    };
  };

  # --- Packages -------------
  home.packages = [
    pkgs.figlet               # Print ASCII art text
    pkgs.nix-zsh-completions  # Completions for Nix, NixOS, NixOps, & ecosystem
    pkgs.with-shell           # Interactive shell where each command starts with cmd prefix
    pkgs.zsh-nix-shell        # ZSH plugin that lets you use ZSH in nix-shell
  ];

  programs.fzf = {
    enable = true;
    changeDirWidgetCommand = "fd --type d";
    changeDirWidgetOptions = [ "--previeww 'tree -C {} | head -200'" ];
    colors = {};
    #defaultCommand = "fd --type f";
    defaultOptions = [ "--height 40%" "--border" ];
    fileWidgetCommand = "fd --type f";
    fileWidgetOptions = ["--preview 'head {}'"];
    historyWidgetOptions = [];  #--sort --exact
  };

}
