
{ self, inputs,
  config, lib, pkgs,
  ...
}:
{
  userChrome =
    import ./chrome/gnome.nix ++
    import ./chrome/default.nix
  ;
  userContent =
    import ./content/gnome.nix ++
    import ./content/default.nix
  ;
}
