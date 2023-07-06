{ inputs, self
, config, lib, pkgs
, ...
}:
let
  overrideCommand = false;
in
{
  imports = [
  ];

  programs.zsh.plugins = lib.mkIf config.programs.fzf.enable [
    # Plugin to use FZF to complete git objects.
    { name = "fzf-git.sh"; file = "fzf-git.sh"; src = pkgs.fetchFromGitHub {
        owner = "junegunn"; repo = "fzf-git.sh";
        sha256 = "02wm7gxb5w40gfzhy34d80hpi1c2brm6nhmy61ln3dyg54ld8wrr";  # Branch: main (7/6/2023)
        rev = "b6192ec86609afea761c7d3954f9b539a512dc80";
      };
    }
  ];

  # Redefining this function to change FZF git completor options
  programs.zsh.initExtraBeforeCompInit = lib.mkIf (config.programs.fzf.enable && overrideCommand) ''
    _fzf_git_fzf() {
      fzf-tmux -p80%,60% -- \
        --layout=reverse --multi --height=50% --min-height=20 --border \
        --border-label-pos=2 \
        --color='header:italic:underline,label:blue' \
        --preview-window='right,50%,border-left' \
        --bind='ctrl-/:change-preview-window(down,50%,border-top|hidden|)' "$@"
    }
  '';
}
