{ config, lib, pkgs, ... }: {
  #imports = [inputs.nix-flatpak.homeManagerModules.nix-flatpak];
  home.packages = [ pkgs.fractal ]; #pkgs.fractal-next;
  services.flatpak = {
    remotes = [
      { name = "flathub-beta";  location = "https://flathub.org/beta-repo/flathub-beta.flatpakrepo"; }
      { name = "flathub";       location = "https://dl.flathub.org/repo/flathub.flatpakrepo";        }
      { name = "gnome-nightly"; location = "https://nightly.gnome.org/gnome-nightly.flatpakrepo";    }
    ];
    packages = [
      { appId = "org.gnome.Fractal";       origin = "flathub";      }
      { appId = "org.gnome.Fractal";       origin = "flathub-beta"; }
      { appId = "org.gnome.Fractal.Devel"; origin = "gnome-nightly"; }
    ];
  };
}
