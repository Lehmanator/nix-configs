{ config, lib, pkgs, ... }:
# https://github.com/unixorn/awesome-zsh-plugins
# http://strcat.de/zsh/#tipps
# TODO: [fast-syntax-highlighting](https://github.com/zdharma-continuum/fast-syntax-highlighting/)
# TODO: https://github.com/chrissicool/zsh-256color
# TODO: https://github.com/hchbaw/auto-fu.zsh
# TODO: https://github.com/bartboy011/cd-reminder
# TODO: https://github.com/ael-code/zsh-colored-man-pages
# TODO: https://github.com/zuxfoucault/colored-man-pages_mod
# https://github.com/Tarrasch/zsh-colors
# https://github.com/zpm-zsh/colors
# https://github.com/zpm-zsh/colorize
# https://github.com/rutchkiwi/copyzshell
# https://github.com/anatolykopyl/doas-zsh-plugin
# https://github.com/Senderman/doas-zsh-plugin # Equiv for sudo?
# https://github.com/mroth/evalcache
# https://github.com/gmatheu/shell-plugins # Explain-shell
# https://github.com/QuarticCat/zsh-fastcache
# https://github.com/smeagol74/zsh-fzf-pass
# https://github.com/micakce/fzf-it
# https://github.com/tom-power/fzf-tab-widgets
# https://github.com/zsh-users/zsh-completions
{
  programs.zsh = {
    prezto = {
      enable = false;

      # Extra ZSH stuff to load. See:
      # - Functions: `$ man zshcontrib`
      # - Modules:   `$ man zshmodules`
      extraFunctions = ["zargs" "zmv"];
      extraModules = ["attr" "stat"];

      pmodules = [
        "environment"
        "terminal"
        "editor"
        "history"
        "directory"
        "spectrum"
        "utility"
        "completion"
        "prompt"
      ];

      # TODO: Separate personal keys from profile-related config.
      # TODO: mkSshIdentities = name: ["id_${name}_rsa" "id_${name}_ed25519"];
      ssh.identities = [
        "id_rsa"
        "id_ed25519"
        "id_lehmanator_ed25519"
        "id_slehman_ed25519"
        "id_slehman_rsa"
      ];
    };

    # TODO: Fetch plugins using nvfetcher & nixpkgs overlay ?
    # TODO: Use plugins from nixpkgs?
    plugins = [
      { # https://github.com/chisui/zsh-nix-shell
        name = "zsh-nix-shell";
        src = pkgs.zsh-nix-shell;
        file = "share/zsh-nix-shell/nix-shell.plugin.zsh";
      }
      { # https://github.com/jeffreytse/zsh-vi-mode
        name = "vi-mode";
        src = pkgs.zsh-vi-mode;
        file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
      }
      { # https://github.com/Aloxaf/fzf-tab
        name = "fzf-tab";
        src = pkgs.zsh-fzf-tab;
        file = "share/fzf-tab/fzf-tab.plugin.zsh";
      }
      { # https://github.com/wfxr/forgit 
        name = "forgit";
        src = pkgs.zsh-forgit;
        file = "share/zsh/zsh-forgit/forgit.plugin.zsh";
      }
    ];
  };
}
