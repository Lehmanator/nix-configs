{ inputs
, config
, lib
, pkgs
, ...
}:
{
  imports = [
    #./chat.nix
    #../../apps/social.nix

    # --- FOSS ---------------------------------------------
    # --- Mastodon ---
    ./tuba

    # --- Proprietary --------------------------------------
    # --- Discord -------
    ./gtkcord
    ./gotktrix

    # --- Reddit ---
    #./headlines

    # --- Telegram ---
    #./paper-plane

    # --- Twitch --------
    ./chatterino
  ];

  home.packages = [
    # --- Reddit --------
    #pkgs.giara  10/25/23: Dep python311Packages.prawcore build fails
    pkgs.headlines

    # --- Signal --------
    pkgs.signal-desktop # TODO: Move to ../../apps/chat.nix

    # --- Bumble --------
    # --- Facebook ------
    # --- Hacker News ---
    # --- Instagram -----
    # --- Snapchat ------
    # --- Telegram ------
    # --- Tinder --------
    # --- Tumblr --------
    # --- Twitter -------
    #pkgs.cawbird    # Deprecated

    # --- Decentralized ------------------------------------
    # --- Matrix --------
    pkgs.element-desktop # TODO: Move to ../../apps/social.nix or ../../apps/chat.nix

    # --- Lemmy ---------
    #pkgs.nur.repos.colinsane.lemoa   # Broken 7/25/2023

    # --- Friendica -----
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
