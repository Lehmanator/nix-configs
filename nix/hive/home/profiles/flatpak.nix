{ self, inputs
, config, lib, pkgs
, options
, flatpak-repos ? { flathub = "https://flathub.org/repo/flathub.flatpakrepo"; }
, ...
}:
#lib.attrsets.recursiveUpdate
{

}
#(lib.optionalAttrs (options?services.flatpak.packages) {
#  services.flatpak.remotes = flatpak-repos;
#  services.flatpak.preInitCommand = "";
#  services.flatpak.postInitCommand = "";
#
#  # TODO: Add all default packages (runtimes, SDKs, themes, libs, plugins, codecs, etc.)
#  services.flatpak.packages = [
#  ];
#})
