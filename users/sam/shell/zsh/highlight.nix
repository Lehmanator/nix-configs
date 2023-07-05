{ self, inputs, cell
, config, lib, pkgs
, ...
}:
{
  imports = [
  ];

  programs.zsh = let
    #sudoProgram = if config.security.doas.enable then "doas" else if config.security.please.enable then "please" else "sudo";
    sudoProgram = "sudo";
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
