
{ inputs
, ...
}:
{

  programs.nixvim.plugins.gitmessenger = {
    enable = false;
    dateFormat = "%c"; # :help strftime()
    floatingWinOps = {
      border = "rounded";  # TODO: Use global styling attrs
    };
    includeDiff = "none"; # none | current | all
  };

}
