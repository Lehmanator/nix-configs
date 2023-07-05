{ self, inputs, cell
, config, lib, pkgs
, ...
}:
{
  imports = [
  ];

  programs.zsh = let
    sudoProgram = with config.security; if doas.enable then "doas" else if please.enable then "please" else "sudo";
    highlightStyles = {
      builtin = "bg=blue";
      command = "bg=blue";
      function = "bg=blue";
    };
  in {
    prezto.syntaxHighlighting.highlighters = [
      "main"
      "brackets"
      "pattern"
      "line"
      "cursor"
      "root"
    ];
    prezto.syntaxHighlighting.pattern = {
      "rm*-rf*" = "fg=white,bold,bg=red";
      "${sudoProgram}*" = "fg=black,bold,bg=yellow";
    };
    prezto.syntaxHighlighting.styles = highlightStyles;
    syntaxHighlighting.enable = true;
    syntaxHighlighting.package = pkgs.zsh-fast-syntax-highlighting;
    syntaxHighlighting.styles = highlightStyles;
  };
}
