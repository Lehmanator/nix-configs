{ inputs
, config, lib, pkgs
, ...
}:
let
  pkgs-common = with pkgs; [
    stdenv.cc.cc
    openssl
    libelf
    # Required
    glib
    bzip2
    # ...
    cups
    nspr
    nss
    libcap
    SDL2
    libusb1
    dbus
    dbus-glib
    libudev0-shim
  ];
  pkgs-gui-common = with pkgs; [ libGL libva libvdpau libcanberra ];
  pkgs-x11 = with pkgs; [
    xorg.libXcomposite
    xorg.libXtst
    xorg.libXrandr
    xorg.libXext
    xorg.libX11
    xorg.libXfixes
    xorg.libXinerama
    xorg.libXcursor
    xorg.libXrender
    xorg.libXScrnSaver
    xorg.libXi
    xorg.libSM
    xorg.libICE
    xorg.libXt
    xorg.libXmu
    xorg.libxcb
    xorg.libXdamage
    xorg.libxshmfence
    xorg.libXxf86vm
    gtk2
    gnome2.GConf
    gnome2.pango
    libappindicator-gtk2
    libdbusmenu-gtk2
    libindicator-gtk2
  ];
  pkgs-wayland = with pkgs; [ gdk-pixbuf ];
  pkgs-pipewire = with pkgs; [ pipewire.lib ];
in
{
  # --- Running Foreign Packages ---------------------------
  # https://unix.stackexchange.com/questions/522822/different-methods-to-run-a-non-nixos-executable-on-nixos
  # https://reflexivereflection.com/posts/2015-02-28-deb-installation-nixos.html
  #nixpkgs.overlays = [inputs.nix-alien.overlays.default];
  environment.systemPackages = [
      #inputs.nix-alien.packages.${pkgs.stdenv.system}.nix-alien
      #pkgs.nix-alien

      # patchelf - Patch binaries to run in NixOS
      pkgs.patchelf

      (
        let
          base = pkgs.appimageTools.defaultFhsEnvArgs;
        in
        pkgs.buildFHSUserEnv (base
        // {
          name = "fhs";
          targetPkgs = pkgs: (base.targetPkgs pkgs) ++ [ pkgs.pkg-config ];
          multiPkgs = pkgs: [ pkgs.dpkg ];
          profile = "export FHS=1";

          # TODO: Use system default shell?
          runScript =
            if config.programs.zsh.enable
            then "zsh"
            else "bash";
          extraOutputsToInstall = [ "dev" ];
        })
      )
    ]
    # steam-run - Quick way to run software w/o having to find libraries, etc. More complete than buildFHSUserEnv. Unfree libs included
    # Usage: $ steam-run <binary>
    # ++ lib.optional
    #   (config.nixpkgs.config.allowUnfree && pkgs.system == "x86_64-linux")
    #   pkgs.steam-run
    ;

  # --- Finding Libraries ----------------------------------
  # System-wide: Set env vars to use LD paths with standard set of libs.
  #environment.variables = {
  #  # TODO: Conditional packages based on desktop environment  (QT/KDE | GNOME)
  #  # TODO: Conditional packages based graphics driver type    (OpenGL | LibVA)
  #  # TODO: Make into lib function & re-use
  #  # TODO: More libs
  #  NIX_LD_LIBRARY_PATH = with config; lib.makeLibraryPath            ( pkgs-common     # stdenv Linux libs
  #    ++ lib.optional (programs.xwayland.enable
  #                  || programs.hyprland.enable || services.xserver.displayManager.gdm.wayland
  #                  || programs.miriway.enable
  #                  || programs.sway.enable                           ) pkgs-wayland    # Wayland if any desktop using it enabled
  #    ++ lib.optional (services.xserver.enable && !environment.noXlibs) pkgs-x11        # X11 unless disable #|| programs.xwayland.enable)
  #    ++ lib.optional  services.xserver.enable                          pkgs-gui-common # Common desktop if xserver enabled
  #    ++ lib.optional  services.pipewire.enable                         pkgs-pipewire   # Pipewire if enabled
  #  );
  #  NIX_LD = lib.fileContents "${pkgs.stdenv.cc}/nix-support/dynamic-linker";   # Error: forbidden in restricted mode ???
  #};

  # TODO: Anything needed to integrate nix-alien, nix-alien-ld, & nix-ld with nix-index-database ?
  # nix-ld    - Patch foreign packages to include their libraries that otherwise cannot be found on NixOS.
  # nix-alien - Discover & save default.nix files to recreate foreign binaries with Nix config. Auto-caching.
  programs.nix-ld = {
    enable = true;
    # TODO: Use same list as buildFHSUserEnv
    libraries = with pkgs; [
      # Common set of libraries used by arbitrary packages.
      stdenv.cc.cc
      nspr
      zlib
      alsa-lib
      pipewire
      at-spi2-atk
      at-spi2-core
      atk
      curl
      expat
      fuse3
      glib
      gdk-pixbuf
      gtk3
      fontconfig
      freetype
      cairo
      pango
      mesa
      libGL
      libdrm
      libnotify
      libpulseaudio
      libappindicator-gtk3
      libuuid
      libusb1
      libxkbcommon
      systemd
      dbus
      #cups
      icu
      openssl
      nss
      xorg.libX11
      xorg.libXScrnSaver
      xorg.libXcomposite
      xorg.libXcursor
      xorg.libXdamage
      xorg.libXext
      xorg.libXfixes
      xorg.libxcb # X11 Libraries
      xorg.libXi
      xorg.libXrandr
      xorg.libXrender
      xorg.libXtst
      xorg.libxkbfile
      xorg.libxshmfence
    ];
  };

  # --- Finding Binaries -----------------------------------
  # Service that symlinks paths in the Nix store to their typical location in more conventional FHS Linux distros
  services.envfs.enable = lib.mkDefault true;
}
