{
  #path = "~/.config/git/gnome.inc";
  condition = "hasconfig:remote.*.url:https://gitlab.gnome.org/**";
  contents = {
    user = {
      email = "gnome@samlehman.dev";
      name = "Sam Lehman";
    };
  };
}
