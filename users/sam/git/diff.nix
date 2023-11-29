{ inputs
, config
, lib
, pkgs
, ...
}:
{
  imports = [
  ];

  programs.git.delta = {
    enable = true;
    #options = {
    #  decorations = {
    #    commit-decoration-style = "bold yellow box ul";
    #    file-decoration-style = "none";
    #    file-style = "bold yellow ul";
    #  };
    #  features = "decorations";
    #  whitespace-error-style = "22 reverse";
    #};
  };

}
