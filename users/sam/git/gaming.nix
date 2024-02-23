{
  #path = "~/.config/git/gaming.inc";
  #condition = "gitdir: ~/Code/gaming";
  condition = "hasconfig:remote.*.url:https://github.com/RedstoneSSB/**";
  contents = {
    core.sshCommand = "ssh -i ~/.ssh/id_redstone_ed25519";
    user = {
      email = "github@redstone.pw";
      name = "Redstone";
    };
  };
}
