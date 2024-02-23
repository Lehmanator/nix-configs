{ pkgs, ... }:
{
  environment.shellAliases = {
    c = "cat";

    # Clear terminal output
    cl = "clear";

    # Editor
    e = "$EDITOR";
    v = "$VISUAL";

    # Reload the shell
    #she = "$SHELL";

    # Paths
    w = "which -a";
  };
}
