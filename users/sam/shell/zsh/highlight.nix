{ self, inputs, cell
, config, lib, pkgs
, ...
}:
{
  imports = [
  ];


  programs.zsh = {
    enableSyntaxHighlighting = true;
    prezto.syntaxHighlighting = {
      highlighters = [
        "main"
        "brackets"
        "pattern"
        "line"
        "cursor"
        "root"
      ];
      pattern = {
        "rm*-rf*" = "fg=white,bold,bg=red";
        "sudo*"   = "fg=black,bold,bg=yellow";
      };
      styles = {
        builtin = "bg=blue";
        command = "bg=blue";
        function = "bg=blue";
      };
    };
  };

}
