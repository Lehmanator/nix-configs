{
  #path = "~/.config/git/gaming.inc";
  #condition = "gitdir: ~/Code/gaming";
  condition = "hasconfig:remote.*.url:https://github.com/RedstoneSSB/**";
  contents = {
    user = {
      email = "me@redstone.pw";
      name = "Redstone";
    };
  };
}
