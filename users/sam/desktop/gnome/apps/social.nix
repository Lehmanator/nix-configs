{ self
, inputs
, config
, lib
, pkgs
, ...
}:
{
  imports = [
    #./chat.nix
    #../../apps/social.nix
  ];

  home.packages = [
    # --- Proprietary --------------------------------------
    # --- Bumble --------

    # --- Discord -------
    pkgs.gtkcord4
    pkgs.gotktrix

    # --- Facebook ------
    # --- Hacker News ---
    # --- Instagram -----

    # --- Reddit --------
    pkgs.giara
    pkgs.headlines

    # --- Signal --------
    pkgs.signal-desktop  # TODO: Move to ../../apps/chat.nix

    # --- Snapchat ------
    # --- Telegram ------
    # --- Tinder --------
    # --- Tumblr --------

    # --- Twitch --------
    pkgs.chatterino2 # TODO: Move to ../../apps/social.nix

    # --- Twitter -------
    #pkgs.cawbird    # Deprecated

    # --- Decentralized ------------------------------------
    # --- Friendica -----
    # --- Lemmy ---------
    #pkgs.nur.repos.colinsane.lemoa   # Broken 7/25/2023

    # --- Mastodon ---
    pkgs.tuba
    pkgs.tootle

    # --- Matrix --------
    pkgs.element-desktop  # TODO: Move to ../../apps/social.nix or ../../apps/chat.nix
    #pkgs.fractal-next

    # --- PixelFed ------

  ];

  #nixpkgs.overlays = [
  #  (final: prev: {
  #    chatty-gtk4 = prev.chatty.overrideAttrs (o: {
  #      patches = (o.patches or [ ]) ++ [ (prev.fetchpatch {
  #        url = "https://source.puri.sm/Librem5/chatty/-/merge_requests/1202.patch";
  #        hash = "sha256-02ww08awmk32ph0kwnx0qgaxdsav77q8n8xwd06ykddrm0h88qks";
  #      })];   #rev = "Librem5/chatty!1202"; hash = "081c3303781963260c11c39a27b88950c1146337";
  #      #src = fetchFromGitLab {
  #      #  domain = "source.puri.sm";
  #      #  owner = "Librem5";
  #      #  repo = "chatty";
  #      #  rev = "b47e38adabb3f738313ab265fb9e8cefd92197fe";  # GTK4 port MR
  #      #  fetchSubmodules = true;
  #      #  hash = "";
  #      #};
  #    });
  #    fractal-next = prev.fractal-next.overrideAttrs (o: {
  #      src = prev.fetchFromGitLab {
  #        domain = "gitlab.gnome.org";
  #        owner = "GNOME";
  #        repo = "fractal";
  #        rev = "cfeae158ad4a4e3f22090a4d2425046b69559358";
  #        hash = "";
  #      };
  #      cargoDeps = null;
  #    });
  #  })
  #];

}
