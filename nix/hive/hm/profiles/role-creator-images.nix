{ config, lib, pkgs , ... }: {
  # TODO: Convert to devShells.creator-images?
  home.packages = [
    # --- Image Generation & Upscaling ---
    pkgs.anime4k   # Realtime upscaler for anime
    pkgs.upscayl   # AI image upscaler
    pkgs.nur.repos.mic92.bing-image-creator

    # --- Image Editing ---
    pkgs.gimp-with-plugins
  ] ++ (with pkgs.gimpPlugins; [
    bimp
    exposureBlend
    farbfeld
    fourier
    gap
    gimplensfun
    gmic
    lightning
    lqrPlugin
    resynthesizer
    texturize
    waveletSharpen
  ]);
}
