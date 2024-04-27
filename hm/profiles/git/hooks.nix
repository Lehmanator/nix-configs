{ self
, inputs
, config
, lib
, pkgs
, ...
}:
{

  programs.git.hooks = {
    #pre-commit = ./pre-commit-script;
  };

}
