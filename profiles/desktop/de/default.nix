{ self, inputs
, lib, config, pkgs
, ...
}:
# Default settings for all desktop environments
{
  imports = [
    ./gnome
  ];

}
