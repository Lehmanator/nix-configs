{
  #path = "~/.config/git/personal.inc";
  #condition = "gitdir: ~/Code/personal";
  condition = "hasconfig:remote.*.url:https://github.com/Lehmanator/**";
  contents = {
    user = {
      email = "github@samlehman.dev";
      name = "Sam Lehman";
    };
  };
}
