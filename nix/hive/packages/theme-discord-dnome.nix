{ fetchFromGitHub, gnumake, less, lessc, lib, nodePackages, stdenv, }:
# TODO: Export ./dist/DNOME.css
stdenv.mkDerivation rec {
  pname = "discord-theme-dnome";
  version = "unstable-2023-11-13";

  src = fetchFromGitHub {
    owner = "GeopJr";
    repo = "DNOME";
    rev = "2eabeaa4d49ed08f95a4ae697276a0327f3c2b3c";
    hash = "sha256-bfzDeky8t/sZcQKse+0dbXaH7zthBJlA+Pju7DmcZyE=";
  };

  buildInputs = [ gnumake less lessc nodePackages.nodejs ];
  buildPhase = ''
    mkdir -p ./dist
    #node gtk/grab_theme_colors.mjs
    lessc $src/src/DNOME.less ./dist/DNOME.css
  '';

  installPhase = ''
    mkdir -p $out
    cp ./dist/DNOME.css $out/
  '';

  # Web App Theme Compiler: https://dnome.geopjr.dev/

  # BetterDiscord: ./DNOME.theme.css in BD's `themes/` dir.
  # DiscoCSS: ~/.config/discocss/custom.css

  # BeautifulDiscord: https://github.com/leovoel/BeautifulDiscord
  # BetterDiscord: https://github.com/rauenzi/BetterDiscordApp
  # Crycord: https://github.com/GeopJr/Crycord
  # Powercord: https://powercord.dev/

  meta = with lib; {
    description = "Adwaita-inspired Discord Theme";
    homepage = "https://github.com/GeopJr/DNOME";
    license = licenses.bsd2;
    maintainers = with maintainers; [ lehmanator ];
    #mainProgram = "dnome";
    platforms = platforms.all;
  };
}
