{ self
, inputs
, config
, lib
, pkgs
  #, useNerdfonts ? true
, ...
}:
# TODO: Convert this file into {nixosModule,homeManagerModule,darwinModule}.nerdfonts
# TODO: Automatically set `nerdfonts = false` when:
#   - `deviceType = server | no-gui | console | terminal`
#   - `defaultTTY = <TerminalApp>` where `<TerminalApp>` doesn't support glyphs
# TODO: lib.defaultTtySupportsGlyphs - Determine if default TTY capable of displaying Nerdfont glyphs
# TODO: lib.deviceTypeSupportsGlyphs - Determine if machine capable of displaying Nerdfont glyphs
# TODO: lib.mkNerdfont - Patch font to use nerdfont symbols.
# TODO: lib.getNerdfontNameOverride - Get `pkgs.nerdfonts.override` string name of font equivalent to a font without nerdfont symbols
# TODO: lib.getNerdfontPackage - Get package (name) of font equivalent to a font without nerdfont symbols
# TODO: lib.getStandardFontPackage - Get package (name) of font equivalent to a font with nerdfont symbols
# TODO: lib.mkNerdfontConfig - Bend config to enable nerdfonts & change options using ASCII/UTF-8 to using glyphs
# TODO: lib.mkNoNerdfontConfig - Bend config to disable nerdfonts & change options using glyphs to ASCII/UTF-8
# TODO: lib.mkDynamcNerdfontConfig - Bend config to use Nerdfonts when remote client SSH, disable during console access. Set env vars via PAM session login

let
  useNerdfonts = lib.mkDefault true;
  favorites = {
    overrides = [
      "Agave"
      "IBMPlexMono" #"Blex Mono"
      "CascadiaCode" #"Caskaydia Cove"
      "CodeNewRoman"
      "Cousine"
      "DaddyTimeMono"
      "DejaVuSansMono"
      "DroidSansMono"
      "FantasqueSansMono"
      "FiraCode"
      "FiraMono"
      "Gohu"
      "Hack"
      "Hermit" #"Hurmit"
      "Inconsolata"
      "Iosevka"
      "JetBrainsMono"
      "LiberationMono" #"LiterationMono"
      "Lilex"
      "Meslo" #"MesloLG"
      "Monofur"
      "Monoid"
      "Mononoki"
      "Noto"
      "ProFont"
      "ProggyClean"
      "OpenDyslexic"
      "RobotoMono"
      "ShareTechMono" #"ShureTechMono"
      "SourceCodePro" #"SauceCodePro"
      "SpaceMono"
      "NerdFontsSymbolsOnly"
      "Terminus" #"Terminess"
      "Ubuntu"
      "UbuntuMono"
      "VictorMono"
    ];
    packages.normal = [
      pkgs.fira-code
    ];
    packages.nerdfonts = [
      pkgs.fira-code-symbols
      pkgs.hackgen-nf-font
      pkgs.inconsolata-nerdfont
      pkgs.maple-mono-NF
      pkgs.meslo-lgs-nf
    ];
  };
in
{
  imports = [
    # TODO: Split ./fonts.nix into ./desktop/fonts.nix & ./shell/fonts.nix
    inputs.home-extra-xhmm.homeManagerModules.desktop.fonts
  ];

  home.packages =
    #let
    #  base = favorites.packages.normal;
    #  nerd = [ pkgs.nerd-font-patcher (pkgs.nerdfonts.override { fonts = favorites.overrides; }) ] ++ favorites.packages.nerdfonts;
    #in
    #if useNerdfonts then base ++ nerd else base;
    [
      pkgs.nerd-font-patcher
      (pkgs.nerdfonts.override { fonts = favorites.overrides; })
      pkgs.fira-code-symbols
      pkgs.hackgen-nf-font
      pkgs.inconsolata-nerdfont
      pkgs.maple-mono-NF
      pkgs.meslo-lgs-nf
    ];

}
