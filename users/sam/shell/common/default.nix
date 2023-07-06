{ self
, inputs
, system
, host
, network
, repo
, userPrimary
, config
, lib
, pkgs
, ...
}:
{
  imports = [
    ./alias.nix
    ./fzf.nix
    ./ls.nix
    ../../pager
  ];

  programs.bash.enableVteIntegration = true;
  programs.bash.historyControl = [ "ignorespace" ];


  # --- Direnv ----------------
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

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
    pkgs.cmatrix # Cool matrix screensaver program
    pkgs.figlet # Print ASCII art text
    pkgs.nix-zsh-completions # Completions for Nix, NixOS, NixOps, & ecosystem
    pkgs.with-shell # Interactive shell where each command starts with cmd prefix
    pkgs.zsh-nix-shell # ZSH plugin that lets you use ZSH in nix-shell
  ];

}
