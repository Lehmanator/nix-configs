{
  condition = "hasconfig:remote.*.url:https://github.com/publicSam/**";
  #path = "~/.config/git/public.inc";
  #condition = "gitdir: ~";
  contents = {
    user = {
      email = "sam@samlehman.dev";
      name = "Sam Lehman";
      #signingKey = "";
    };
    #commit.gpgSign = true;
  };
}
