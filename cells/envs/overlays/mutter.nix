# Mutter patched to use dynamic triple buffering
#   Patch retrieved from AUR package: mutter-dynamic-buffering (03/31/2023)
final: prev: {
  gnome = prev.gnome.overrideScope' (gfinal: gprev: {
    mutter = gprev.mutter.overrideAttrs (old : {
      patches = (old.patches or []) ++ [

	# GNOME Dynamic Triple Buffering
        (prev.fetchpatch {
	  url = "https://aur.archlinux.org/cgit/aur.git/plain/mr1441.patch?h=mutter-dynamic-buffering";
	  sha256 = "";
	})

	# X11 avoid updating focus on Wayland compositor
	(prev.fetchpatch {
	  url = "https://gitlab.gnome.org/GNOME/mutter/-/commit/d5e75bccdee7ea0e30cd860ca08ae109dcb311c8.patch";
	  sha256 = "";
	})

	# X11 fractional display scaling w/ XRandr
        # https://salsa.debian.org/gnome-team/mutter/-/blob/ubuntu/master/debian/patches/x11-Add-support-for-fractional-scaling-using-Randr.patch
        (super.fetchpatch {
          url = "https://salsa.debian.org/gnome-team/mutter/-/raw/91d9bdafd5d624fe1f40f4be48663014830eee78/debian/patches/x11-Add-support-for-fractional-scaling-using-Randr.patch";
          sha256 = "m6PKjVxhGVuzsMBVA82UyJ6Cb1s6SMI0eRooa+F2MY8=";
        })
      ];
    });
    gnome-control-center = gprev.gnome-control-center.overrideAttrs (oldAttrs: {
      patches = oldAttrs.patches ++ [

        # Display scaling UI logical monitor mode
        # https://salsa.debian.org/gnome-team/gnome-control-center/-/blob/ubuntu/master/debian/patches/ubuntu/display-Support-UI-scaled-logical-monitor-mode.patch
        (super.fetchpatch {
          url = "https://salsa.debian.org/gnome-team/gnome-control-center/-/raw/f185f33fb200cc963c062c7a82920a085f696978/debian/patches/ubuntu/display-Support-UI-scaled-logical-monitor-mode.patch";
          sha256 = "XBMD0chaV6GGg3R9/rQnsBejXspomVZz/a4Bvv/AHCA=";
        })

        # Display show fractional scaling setting
        # https://salsa.debian.org/gnome-team/gnome-control-center/-/blob/ubuntu/master/debian/patches/ubuntu/display-Allow-fractional-scaling-to-be-enabled.patch
        (super.fetchpatch {
          url = "https://salsa.debian.org/gnome-team/gnome-control-center/-/raw/f185f33fb200cc963c062c7a82920a085f696978/debian/patches/ubuntu/display-Allow-fractional-scaling-to-be-enabled.patch";
          sha256 = "Pm6PTmsL2bW9JAHD1u0oUEqD1PCIErOlcuqlwvP593I=";
        })

      ];
    });
  });
}
